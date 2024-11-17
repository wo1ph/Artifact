import Foundation
import RealityKit
import ArtifactScenes

enum SceneLoadingState {
    case notLoaded
    case loading
    case loaded
    case failed(Error)
}

class ArtifactScenesViewModel: ObservableObject {
    @Published var selectedSceneName: String
    @Published private(set) var sceneLoadingState: SceneLoadingState = .notLoaded
    
    private var sceneCache: [String: Entity] = [:]
    private var preloadTasks: Set<Task<Void, Never>> = []
    private let maxCacheSize = 4
    
    private let journeyProgressManager = JourneyProgressManager()
    
    private var currentIndex: Int = 0
    private var artifacts: [Artifact] = []
    private var journeyPrefix: String = ""
    
    init(initialSceneName: String, artifacts: [Artifact] = [], journeyPrefix: String = "") {
        self.selectedSceneName = initialSceneName
        self.artifacts = artifacts
        self.journeyPrefix = journeyPrefix
        
        if let initialIndex = artifacts.firstIndex(where: { $0.sceneName == initialSceneName }) {
            self.currentIndex = initialIndex
        }
    }
    
    func selectScene(named sceneName: String) async {
        // Run UI updates on main thread
        await MainActor.run {
            if let newIndex = artifacts.firstIndex(where: { $0.sceneName == sceneName }) {
                currentIndex = newIndex
                selectedSceneName = sceneName
            }
        }
        
        cancelPreloadTasks()
        await loadSelectedAndPreloadNext()
        
        // if the scene loaded successfully,
        // mark it as viewed in UserDefaults
        if case .loaded = sceneLoadingState {
            journeyProgressManager.markArtifactViewed(journeyPrefix: journeyPrefix, artifactName: sceneName)
        }
    }
    
    private func loadSelectedAndPreloadNext() async {
        // Load current scene if needed
        await loadSceneIfNeeded(named: selectedSceneName, priority: .high)
        
        // Preload next scenes
        await preloadUpcomingScenes()
        cleanupCache()
    }
    
    private func loadSceneIfNeeded(named sceneName: String, priority: TaskPriority = .medium) async {
        guard sceneCache[sceneName] == nil else { return }
        
        // Update loading state on main thread
        await MainActor.run {
            sceneLoadingState = .loading
        }
        
        do {
            let scene = try await Entity(named: "\(journeyPrefix)/\(journeyPrefix)_\(sceneName)",
                                         in: artifactScenesBundle)
            // Cache and update state on main thread
            await MainActor.run {
                sceneCache[sceneName] = scene
                sceneLoadingState = .loaded
            }
        } catch {
            print("Error loading scene \(sceneName): \(error)")
            await MainActor.run {
                sceneLoadingState = .failed(error)
            }
        }
    }
    
    private func cancelPreloadTasks() {
        preloadTasks.forEach { $0.cancel() }
        preloadTasks.removeAll()
    }
    
    private func preloadUpcomingScenes() async {
        // Determine next scenes to preload
        let upcomingIndices = getUpcomingIndices()
        
        // Create preload tasks
        for index in upcomingIndices {
            let sceneName = artifacts[index].sceneName
            let task = Task(priority: .low) {
                await loadSceneIfNeeded(named: sceneName)
            }
            preloadTasks.insert(task)
        }
    }
    
    private func getUpcomingIndices() -> [Int] {
        let nextIndices = (currentIndex + 1)...(currentIndex + 2)
        return nextIndices.filter { $0 < artifacts.count }
    }
    
    private func cleanupCache() {
        // Keep only current and adjacent models in cache
        let keepIndices = Set((max(0, currentIndex - 1)...min(artifacts.count - 1, currentIndex + 2)))
        let keepSceneNames = Set(keepIndices.map { artifacts[$0].sceneName })
        
        // Remove scenes that are no longer needed
        sceneCache = sceneCache.filter { keepSceneNames.contains($0.key) }
    }
    
    func getCachedScene(named sceneName: String) -> Entity? {
        return sceneCache[sceneName]
    }
    
    deinit {
        cancelPreloadTasks()
    }
}
