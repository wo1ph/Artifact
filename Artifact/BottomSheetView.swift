import SwiftUI

struct BottomSheetView: View {
    let sceneName: String
    @ObservedObject var viewModel: JourneyViewModel
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: {
            viewModel.selectedSceneName = sceneName  // Primary action: change 3D model
        }) {
            VStack {
                HStack {
                    Text(sceneName)
                        .font(.headline)
                        .padding()
                    Spacer()
                }
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
        .onLongPressGesture {
            showingDetail = true  // Secondary action: show details
        }
        .sheet(isPresented: $showingDetail) {
            Text("Details")
        }
    }
}
