import Foundation

@MainActor
class JourneysViewModel: ObservableObject {
    @Published var journeys: [Journey] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service = JourneyService()
    
    func loadJourneys() {
        // Don't make real network request in Preview
        guard !ProcessInfo.isPreview else {
            journeys = Journey.sampleJourneys
            return
        }
        
        isLoading = true
        
        Task {
            do {
                journeys = try await service.fetchJourneys()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}

extension ProcessInfo {
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

