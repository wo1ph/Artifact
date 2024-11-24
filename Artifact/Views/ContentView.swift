import SwiftUI

struct ContentView: View {
    @StateObject private var journeysViewModel = JourneysViewModel()
    
    var body: some View {
        NavigationView {
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
        }
        .onAppear {
            journeysViewModel.loadJourneys()
        }
    }
}

#Preview {
    ContentView()
}
