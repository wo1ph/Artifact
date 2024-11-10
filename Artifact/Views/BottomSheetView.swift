import SwiftUI

struct BottomSheetView: View {
    let sceneName: String
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
                    Button("About") {
                        showingDetail = true
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
            Text("Details")
        }
    }
}
