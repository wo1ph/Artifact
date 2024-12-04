import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = !OnboardingManager.shared.hasSeenOnboarding
    @StateObject private var journeysViewModel = JourneysViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(journeysViewModel.journeys, id: \.self.title) { journey in
                        NavigationLink(destination: JourneyDetailView(journey)) {
                            JourneyCardView(journey)
                        }
                        .foregroundStyle(.primary)
                    }
                }
                .padding()
            }
            .navigationTitle("Journeys")
        }
        .onAppear {
            journeysViewModel.loadJourneys()
        }
        .fullScreenCover(isPresented: $showOnboarding, onDismiss: {
            OnboardingManager.shared.hasSeenOnboarding = true
        }) {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
