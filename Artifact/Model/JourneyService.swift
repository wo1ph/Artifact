import Foundation

class JourneyService {
    private let apiURL = "https://gn4xt2b916.execute-api.us-east-2.amazonaws.com/prod/journeys"
    private let apiKey = "tP731AxMWA61ISM5XIaUf3XSdLQf8n3EnC8Jc660" // throttled, so ok to be public
    
    func fetchJourneys() async throws -> [Journey] {
        var request = URLRequest(url: URL(string: apiURL)!)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Journey].self, from: data)
    }
}
