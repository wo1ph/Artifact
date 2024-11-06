import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(Journey.sampleJourneys, id: \.self.title) { journey in
                        NavigationLink(destination: JourneyDetailView(journey)) {
                            JourneyCardView(journey)
                        }
                        .foregroundStyle(.primary)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
