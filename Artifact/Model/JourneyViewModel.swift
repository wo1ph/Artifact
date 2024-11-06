import Foundation

class JourneyViewModel: ObservableObject {
    @Published var selectedSceneName: String

    init(initialSceneName: String) {
        self.selectedSceneName = initialSceneName
    }
}
