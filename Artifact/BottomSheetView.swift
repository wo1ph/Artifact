import SwiftUI


struct BottomSheetView: View {
    let sceneName: String
    @ObservedObject var viewModel: JourneyViewModel

    private let closedOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    private let openOffset: CGFloat = 100

    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        VStack {
            HStack {
                Text(sceneName)
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(10)

            VStack(alignment: .leading) {
                Text("Description for \(sceneName)")
                    .padding()
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(20)
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
        .offset(y: max(offset + dragOffset, openOffset))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    dragOffset = gesture.translation.height
                }
                .onEnded { _ in
                    if dragOffset < -100 {
                        offset = openOffset
                    } else if dragOffset > 100 {
                        offset = closedOffset
                    }
                    dragOffset = 0
                }
        )
        .animation(.spring(), value: dragOffset)
        .onTapGesture {
            viewModel.selectedSceneName = sceneName
        }
    }
}
