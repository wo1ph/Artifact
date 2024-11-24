import SwiftUI

struct JourneyDetailView: View {
    let journey: Journey
    let journeyProgressManager = JourneyProgressManager()
    
    @State private var viewedArtifactsCount: Int = 0
    
    init(_ journey: Journey) {
        self.journey = journey
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerContent
                
                Text("\(viewedArtifactsCount)/\(journey.artifacts.count) Artifacts discovered")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                NavigationLink(destination: JourneyRealityView(journey)) {
                    Text("Start Journey")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.vertical, 8)
                
                Text(journey.description)
                    .font(.body)
                    .padding(.horizontal)
            }
            .padding()
        }
        .onAppear {
            viewedArtifactsCount = journeyProgressManager.getViewedArtifacts(for: journey.artifactPrefix).count
        }
        .navigationTitle(journey.title)
        
    }
    
    @ViewBuilder
    var headerContent: some View {
        AsyncImage(url: URL(string: journey.imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)
            } else {
                Color.gray
                    .frame(height: 300)
                    .cornerRadius(10)
            }
        }
        
        Text(journey.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 8)
            .padding(.horizontal)
    }
}

#Preview {
    JourneyDetailView(Journey.sampleJourneys.first!)
}
