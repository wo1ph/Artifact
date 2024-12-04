import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    let pages = [
        OnboardingPage(
            image: "map",
            title: "Choose your Journey",
            description: "A Journey is an immersive and interactive exploration. Browse through a variety of destinations and select one to begin your adventure. Within, you will uncover mixed reality scenes to learn about fascinating topics."
        ),
        OnboardingPage(
            image: "magnifyingglass",
            title: "Discover ARtifacts",
            description: "ARtifacts are 3D objects that bring Journeys to life, right in your space! After starting a Journey, select an ARtifact at the bottom of the screen to view it in augmented reality. Move, scale, and rotate it to inspect every detail further."
        )
    ]
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    private var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Skip") {
                        dismiss()
                    }
                    .foregroundColor(textColor)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                }
                
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        VStack(spacing: 40) {
                            Image(systemName: pages[index].image)
                                .font(.system(size: 80, weight: .light))
                                .foregroundColor(textColor)
                                .frame(height: 80)
                            
                            VStack(spacing: 16) {
                                Text(pages[index].title)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(textColor)
                                
                                Text(pages[index].description)
                                    .font(.system(size: 16))
                                    .lineSpacing(4)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(textColor.opacity(0.8))
                                    .padding(.horizontal, 32)
                                    .frame(maxWidth: 360)
                            }
                        }
                        .padding(.bottom, 40)
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
                VStack(spacing: 32) {
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? textColor : textColor.opacity(0.5))
                                .frame(width: 8, height: 8)
                                .scaleEffect(currentPage == index ? 1.2 : 1.0)
                                .animation(.spring(), value: currentPage)
                        }
                    }
                    
                    Button(action: {
                        if currentPage < pages.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            dismiss()
                        }
                    }) {
                        Text(currentPage < pages.count - 1 ? "Continue" : "Get Started")
                            .font(.headline)
                            .foregroundColor(backgroundColor)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(textColor)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 48)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
