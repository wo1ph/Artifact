import SwiftUI
import RealityKit
import ArtifactScenes


struct JourneyRealityView: View {
    let journey: Journey
    
    @StateObject private var viewModel: JourneyViewModel
    @State private var scale: Float = 1.0
    @State private var rotation: Float = 0.0
    @State private var position: SIMD3<Float> = SIMD3(x: 0, y: 0.3, z: 0)
    
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
        ZStack(alignment: .bottom) {
            realityView
            artifactSheets
        }
    }
    
    var realityView: some View {
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
        .gesture(scaleGesture)
        .simultaneousGesture(rotateGesture)
        .simultaneousGesture(moveGesture)
        .onTapGesture(count: 2) {
            resetScene()
        }
        .ignoresSafeArea()
    }
    
    var artifactSheets: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(journey.artifacts) { artifact in
                    BottomSheetView(sceneName: artifact.sceneName,
                                    info: artifact.info,
                                    viewModel: viewModel)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var scaleGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let delta = Float(value - 1.0)
                let newScale = scale + delta
                let constrainedScale = min(max(newScale, 0.1), 3.0)
                
                if let anchor = currentScene {
                    anchor.children.first?.scale = [constrainedScale, constrainedScale, constrainedScale]
                }
            }
            .onEnded { _ in
                if let anchor = currentScene,
                   let currentScale = anchor.children.first?.scale.x {
                    scale = currentScale
                }
            }
    }
    
    var rotateGesture: some Gesture {
        RotationGesture()
            .onChanged { angle in
                let newRotation = Float(angle.radians) + rotation
                if let anchor = currentScene {
                    anchor.children.first?.orientation = simd_quatf(angle: newRotation, axis: SIMD3(0, 1, 0))
                }
            }
            .onEnded { angle in
                rotation += Float(angle.radians)
                rotation = rotation.truncatingRemainder(dividingBy: Float.pi * 2)
            }
    }
    
    var moveGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let translation = value.translation
                let newX = position.x + Float(translation.width) * 0.005
                let newZ = position.z + Float(translation.height) * 0.005
                
                if let anchor = currentScene {
                    anchor.position = SIMD3(x: newX, y: position.y, z: newZ)
                }
            }
            .onEnded { _ in
                if let anchor = currentScene {
                    position = anchor.position
                }
            }
    }
    
    @MainActor
    private func loadScene(named sceneName: String) async {
        do {
            let scene = try await Entity(named: "\(journey.artifactPrefix)/\(journey.artifactPrefix)_\(sceneName)", in: artifactScenesBundle)
            let anchor = AnchorEntity(plane: .horizontal, classification: .floor)
            anchor.position = SIMD3(x: 0, y: 0.3, z: 0)
            anchor.addChild(scene)
            currentScene = anchor
        } catch {
            print("Error loading scene \(sceneName): \(error)")
        }
    }
    
    private func resetScene() {
        scale = 1.0
        rotation = 0.0
        position = SIMD3(x: 0, y: 0.3, z: 0)
        
        if let anchor = currentScene {
            anchor.position = position
            if let model = anchor.children.first {
                model.scale = [scale, scale, scale]
                model.orientation = simd_quatf(angle: rotation, axis: SIMD3(0, 1, 0))
            }
        }
    }
}

#Preview {
    JourneyRealityView(Journey.sampleJourneys[0])
}
