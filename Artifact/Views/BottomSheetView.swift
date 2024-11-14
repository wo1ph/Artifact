import SwiftUI

struct BottomSheetView: View {
    let sceneName: String
    let info: String
    @ObservedObject var viewModel: JourneyViewModel
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: {
            viewModel.selectedSceneName = sceneName
        }) {
            VStack {
                HStack {
                    Text(sceneName.replacingOccurrences(of: "_", with: " "))
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
            Text(info)
                .padding(.horizontal, 40)
        }
    }
}

#Preview {
    BottomSheetView(sceneName: "Chichen Itza", info: "Once a thriving Maya city, Chichen Itza is home to the iconic El Castillo pyramid, an architectural masterpiece that reveals the Maya’s advanced understanding of astronomy.", viewModel: .init(initialSceneName: "Chichen Itza", artifacts: [], journeyPrefix: ""))
}
