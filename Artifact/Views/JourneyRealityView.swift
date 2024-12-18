import SwiftUI
import RealityKit
import ArtifactScenes


struct JourneyRealityView: View {
    let journey: Journey
    
    @StateObject private var artifactScenesViewModel: ArtifactScenesViewModel
    @State private var scale: Float = 1.0
    @State private var rotation: Float = 0.0
    @State private var position: SIMD3<Float> = SIMD3(x: 0, y: 0.3, z: 0)
    
    @State private var anchorEntity: AnchorEntity?
    
    init(_ journey: Journey) {
        self.journey = journey
        
        let initialSceneName = journey.artifacts.first?.sceneName ?? ""
        _artifactScenesViewModel = StateObject(wrappedValue: ArtifactScenesViewModel(
            initialSceneName: initialSceneName,
            artifacts: journey.artifacts,
            journeyPrefix: journey.artifactPrefix
        ))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            realityView
            if case .loading = artifactScenesViewModel.sceneLoadingState {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.0)
            }
            artifactSheets
        }
    }
    
    var realityView: some View {
        RealityView { content in
            content.camera = .spatialTracking
            let anchor = AnchorEntity(plane: .horizontal, classification: .floor)
            anchor.position = position
            content.add(anchor)
            anchorEntity = anchor
            
            Task {
                await artifactScenesViewModel.selectScene(named: artifactScenesViewModel.selectedSceneName)
            }
        } update: { content in
            Task {
                await updateScene()
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
                    BottomSheetView(artifact: artifact,
                                    viewModel: artifactScenesViewModel)
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
                
                if let anchor = anchorEntity,
                   let model = anchor.children.first {
                    model.scale = [constrainedScale, constrainedScale, constrainedScale]
                }
            }
            .onEnded { _ in
                if let anchor = anchorEntity,
                   let currentScale = anchor.children.first?.scale.x {
                    scale = currentScale
                }
            }
    }
    
    var rotateGesture: some Gesture {
        RotationGesture()
            .onChanged { angle in
                let newRotation = Float(angle.radians) + rotation
                if let anchor = anchorEntity,
                   let model = anchor.children.first {
                    model.orientation = simd_quatf(angle: newRotation, axis: SIMD3(0, 1, 0))
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
                let newX = position.x + Float(translation.width) * 0.003
                let newZ = position.z + Float(translation.height) * 0.003
                
                if let anchor = anchorEntity {
                    anchor.position = SIMD3(x: newX, y: position.y, z: newZ)
                }
            }
            .onEnded { _ in
                if let anchor = anchorEntity {
                    position = anchor.position
                }
            }
    }
    
    private func resetScene() {
        scale = 1.0
        rotation = 0.0
        position = SIMD3(x: 0, y: 0.3, z: 0)
        
        if let anchor = anchorEntity,
           let model = anchor.children.first {
            anchor.position = position
            model.scale = [scale, scale, scale]
            model.orientation = simd_quatf(angle: rotation, axis: SIMD3(0, 1, 0))
        }
    }
    
    @MainActor
    private func updateScene() async {
        guard let anchor = anchorEntity else { return }
        
        anchor.children.removeAll()
        
        // Get scene from cache
        if let scene = artifactScenesViewModel.getCachedScene(named: artifactScenesViewModel.selectedSceneName)?.clone(recursive: true) {
            configureScene(scene)
            anchor.addChild(scene)
        }
    }
    
    private func configureScene(_ scene: Entity) {
        scene.scale = [scale, scale, scale]
        scene.orientation = simd_quatf(angle: rotation, axis: SIMD3(0, 1, 0))
    }
}

#Preview {
    JourneyRealityView(Journey.sampleJourneys[1])
}
