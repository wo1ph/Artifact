import SwiftUI

struct BottomSheetView: View {
    let artifact: Artifact
    
    let journeyProgressManager = JourneyProgressManager()
    
    @ObservedObject var viewModel: ArtifactScenesViewModel
    @State private var showingDetail = false
    
    var artifactName: String {
        artifact.sceneName.replacingOccurrences(of: "_", with: " ")
    }
    
    var body: some View {
        Button(action: {
            Task {
                await viewModel.selectScene(named: artifact.sceneName)
            }
        }) {
            VStack {
                HStack {
                    Text(artifactName)
                        .font(.headline)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    Button(action: {
                        showingDetail = true
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .frame(width: UIScreen.main.bounds.width * 0.7)
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingDetail) {
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

                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
    }
}

#Preview {
    let artifact = Journey.sampleJourneys.first!.artifacts.first!
    BottomSheetView(artifact: artifact, viewModel: .init(initialSceneName: artifact.sceneName, artifacts: [], journeyPrefix: ""))
}
