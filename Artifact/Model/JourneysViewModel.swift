import Foundation

@MainActor
class JourneysViewModel: ObservableObject {
    @Published var journeys: [Journey] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service = JourneyService()
    
    func loadJourneys() {
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

