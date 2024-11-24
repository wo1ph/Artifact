import SwiftUI

struct JourneyCardView: View {
    let journey: Journey
    
    init(_ journey: Journey) {
        self.journey = journey
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: journey.imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Color.gray
                        .frame(height: 200)
                        .cornerRadius(10)
                }
                
                Text(journey.title)
                    .font(.headline)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(journey.tagLine)
            }
            .frame(width: 300)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview {
    JourneyCardView(Journey.sampleJourneys[0])
}
