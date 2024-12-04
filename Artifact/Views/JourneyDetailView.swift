import SwiftUI

struct JourneyDetailView: View {
    let journey: Journey
    let journeyProgressManager = JourneyProgressManager()
    
    @State private var viewedArtifactsCount: Int = 0
    @State private var headerOffset: CGFloat = 0
    @State private var titleOffset: CGFloat = 30
    @State private var titleOpacity: Double = 0
    
    init(_ journey: Journey) {
        self.journey = journey
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerContent
                    .offset(y: headerOffset)
                
                VStack(alignment: .center, spacing: 20) {
                    VStack(spacing: 12) {
                        Text("\(viewedArtifactsCount)/\(journey.artifacts.count) Artifacts discovered")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        ProgressView(value: Double(viewedArtifactsCount), total: Double(journey.artifacts.count))
                            .progressViewStyle(.linear)
                            .tint(buttonColor)
                            .frame(width: 200)
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    NavigationLink(destination: JourneyRealityView(journey)) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.headline)
                            Text("Start Journey")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 2, y: 1)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    Text(journey.description)
                        .font(.body)
                        .lineSpacing(8)
                        .opacity(0.9)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewedArtifactsCount = journeyProgressManager.getViewedArtifacts(for: journey.artifactPrefix).count
            withAnimation(.easeOut(duration: 0.8)) {
                titleOffset = 0
                titleOpacity = 1
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    @ViewBuilder
    var headerContent: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: journey.imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .clipped()
                } else {
                    Color.gray
                        .frame(height: 400)
                }
            }
            
            LinearGradient(
                gradient: Gradient(colors: [
                    .black.opacity(0.9),
                    .black.opacity(0.7),
                    .black.opacity(0.4),
                    .clear
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 250)
            
            Text(journey.title)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 40)
                .offset(y: titleOffset)
                .opacity(titleOpacity)
        }
    }
    
    private var buttonColor: Color {
        Color(uiColor: UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
            ? UIColor(white: 0.2, alpha: 1)  // Slightly off-black for dark mode
            : UIColor(white: 0.1, alpha: 1)  // Near-black for light mode
        })
    }
}

#Preview {
    JourneyDetailView(Journey.sampleJourneys[1])
}
