import SwiftUI
import RealityKit
import ArtifactScenes


struct JourneyRealityView: View {
    let journey: Journey

    @StateObject private var viewModel: JourneyViewModel

    init(_ journey: Journey) {
        self.journey = journey
        
        let initialSceneName: String
        if let firstArtifact = journey.artifacts.first {
            initialSceneName = firstArtifact.sceneName
        } else {
            initialSceneName = ""
        }

        _viewModel = StateObject(wrappedValue: JourneyViewModel(initialSceneName: initialSceneName))
    }

    @State private var currentScene: Entity?

    var body: some View {
        ZStack {
            RealityView { content in
                content.camera = .spatialTracking
                if let scene = currentScene {
                    content.add(scene)
                }
            } update: { content in
                content.entities.removeAll()
                if let scene = currentScene {
                    content.add(scene)
                }
            }
            .onAppear {
                Task {
                    await loadScene(named: viewModel.selectedSceneName)
                }
            }
            .onChange(of: viewModel.selectedSceneName) {
                Task {
                    await loadScene(named: viewModel.selectedSceneName)
                }
            }
            .ignoresSafeArea()

            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(journey.artifacts) { artifact in
                            BottomSheetView(sceneName: artifact.sceneName, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }

    @MainActor
    private func loadScene(named sceneName: String) async {
        do {
            let scene = try await Entity(named: "\(journey.artifactPrefix)_\(sceneName)", in: artifactScenesBundle)
            let anchor = AnchorEntity(plane: .horizontal)
            anchor.addChild(scene)
            currentScene = anchor
        } catch {
            print("Error loading scene \(sceneName): \(error)")
        }
    }
}

//#Preview {
//    JourneyRealityView()
//}
