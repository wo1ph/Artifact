import Foundation

class JourneyProgressManager {
    private let defaults = UserDefaults.standard
    private let viewedArtifactsKey = "viewedArtifacts"
    
    func getViewedArtifacts(for journeyPrefix: String) -> Set<String> {
        let key = "\(viewedArtifactsKey)_\(journeyPrefix)"
        return Set(defaults.stringArray(forKey: key) ?? [])
    }
        
    func markArtifactViewed(journeyPrefix: String, artifactName: String) {
        let key = "\(viewedArtifactsKey)_\(journeyPrefix)"
        var viewed = getViewedArtifacts(for: journeyPrefix)
        viewed.insert(artifactName)
        defaults.set(Array(viewed), forKey: key)
    }
}
