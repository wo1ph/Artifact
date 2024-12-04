import Foundation

class OnboardingManager {
    static let shared = OnboardingManager()
    private let defaults = UserDefaults.standard
    
    private let hasSeenOnboardingKey = "hasCompletedInitialOnboarding"
    
    var hasSeenOnboarding: Bool {
        get { defaults.bool(forKey: hasSeenOnboardingKey) }
        set { defaults.set(newValue, forKey: hasSeenOnboardingKey) }
    }
    
    func resetOnboarding() {
        hasSeenOnboarding = false
    }
}
