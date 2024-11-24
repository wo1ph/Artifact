import SwiftUI

struct BottomSheetView: View {
    let sceneName: String
    let info: String
    
    let journeyProgressManager = JourneyProgressManager()
    
    @ObservedObject var viewModel: ArtifactScenesViewModel
    @State private var showingDetail = true // TODO: Change to False
    
    var artifactName: String {
        sceneName.replacingOccurrences(of: "_", with: " ")
    }
    
    var body: some View {
        Button(action: {
            Task {
                await viewModel.selectScene(named: sceneName)
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
                    Text("Chichen Itza")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 40)
                    
                    Text("Once a thriving Maya city, Chichen Itza is home to the iconic El Castillo pyramid, an architectural masterpiece that reveals the Maya’s advanced understanding of astronomy.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 30)
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
    BottomSheetView(sceneName: "Chichen Itza", info: "Once a thriving Maya city, Chichen Itza is home to the iconic El Castillo pyramid, an architectural masterpiece that reveals the Maya’s advanced understanding of astronomy.", viewModel: .init(initialSceneName: "Chichen Itza", artifacts: [], journeyPrefix: ""))
}
