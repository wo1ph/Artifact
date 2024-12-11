import SwiftUI

struct BottomSheetView: View {
    let artifact: Artifact
    let journeyProgressManager = JourneyProgressManager()
    
    @ObservedObject var viewModel: ArtifactScenesViewModel
    @State private var showingDetail = false
    
    var artifactName: String {
        artifact.sceneName.replacingOccurrences(of: "_", with: " ")
    }
    
    private var isSelected: Bool {
        viewModel.selectedSceneName == artifact.sceneName
    }
    
    var body: some View {
        Button(action: {
            Task {
                await viewModel.selectScene(named: artifact.sceneName)
            }
        }) {
            HStack(spacing: 16) {
                Text(artifactName)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : .black)
                
                Spacer()
                
                Button(action: {
                    showingDetail = true
                }) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(isSelected ? .white.opacity(0.9) : .black.opacity(0.3))
                        .font(.system(size: 24))
                }
                .padding(8)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(isSelected ? .black : .white)
            }
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    .opacity(isSelected ? 0 : 1)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(isSelected ? .white.opacity(0.3) : .clear, lineWidth: 1)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: UIScreen.main.bounds.width * 0.7)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
        .sheet(isPresented: $showingDetail) {
            sheetContent
        }
    }
    
    var sheetContent: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
                .edgesIgnoringSafeArea(.bottom)
            
            VStack(spacing: 16) {
                Text(artifactName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                Text(artifact.info)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 30)
                
                AsyncImage(url: URL(string: "https://artifact-ios.s3.us-east-2.amazonaws.com/\(artifact.sceneName.lowercased())")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.bottom, 16)
            
            // sheet drag bar
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 40, height: 5)
                .foregroundColor(.gray)
                .opacity(0.5)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

#Preview {
    let artifact = Journey.sampleJourneys.first!.artifacts.first!
    BottomSheetView(artifact: artifact, viewModel: .init(initialSceneName: artifact.sceneName, artifacts: [], journeyPrefix: ""))
}
