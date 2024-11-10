struct Journey {
    let imageUrl: String
    let title: String
    let description: String
    let artifactPrefix: String
    let artifacts: [Artifact]
    
    static let sampleJourneys = [
        Journey(imageUrl: "https://artifact-ios.s3.us-east-2.amazonaws.com/7.jpg", title: "7 wonders", description: "Embark on a journey to explore the legendary New 7 Wonders of the World, marvels that span continents and time. From the ancient walls that stretch across China to the towering statue overlooking Rio, each wonder tells a story of human achievement and cultural legacy. Encounter the architectural splendor of Petra, the timeless beauty of the Taj Mahal, and the majestic terraces of Machu Picchu. Stand before the enduring grandeur of Chichen Itza and the epic arches of the Roman Colosseum. This journey isn’t just about visiting places—it’s a path through history, mystery, and the extraordinary tales behind the world’s most iconic structures. Let each wonder inspire awe, ignite curiosity, and deepen your connection to the world’s shared heritage.", artifactPrefix: "7", artifacts: [Artifact(sceneName: "Colosseum", info: "This ancient amphitheater in Rome hosted gladiator battles and public spectacles, embodying the grandeur of Roman engineering and the era’s complex social life."), Artifact(sceneName: "Great_Wall", info: "A massive architectural feat, the Great Wall stretches thousands of miles across northern China, originally built to protect against invasions and now a symbol of resilience and history."), Artifact(sceneName: "Petra", info: "Known as the “Rose City” for its pink sandstone cliffs, Petra is an ancient city carved into rock, showcasing the Nabatean civilization's architectural and engineering prowess."),Artifact(sceneName: "Christ_the_Redeemer", info: "Towering above Rio de Janeiro, this colossal statue of Jesus Christ stands with open arms, symbolizing peace, protection, and a warm welcome to visitors from all over the world."), Artifact(sceneName: "Machu_Picchu", info: "Nestled high in the Andes, this Inca citadel is a marvel of ancient engineering, blending seamlessly with the rugged mountain landscape and offering insights into a lost civilization."), Artifact(sceneName: "Taj_Mahal", info: "Built as a monument of love, the Taj Mahal is a stunning marble mausoleum with intricate inlay work, gardens, and symmetry, reflecting the beauty and devotion of the Mughal era."), Artifact(sceneName: "Chichen_Itza", info: "Once a thriving Maya city, Chichen Itza is home to the iconic El Castillo pyramid, an architectural masterpiece that reveals the Maya’s advanced understanding of astronomy.")]),
        Journey(imageUrl: "https://artifact-ios.s3.us-east-2.amazonaws.com/solar-system.jpg", title: "Solar System", description: "Embark on a journey across the vast expanses of our solar system, where each planet holds unique mysteries and characteristics. From the fiery surface of Mercury to the distant, icy reaches of Neptune, explore the wonders orbiting our Sun. Glide past the swirling clouds of Jupiter, marvel at the rings of Saturn, and witness the vibrant landscapes of Mars. This journey invites you to experience the solar system’s scale, diversity, and the celestial beauty that lies beyond Earth, connecting us to the greater cosmos with every orbit.", artifactPrefix: "Solar", artifacts: [Artifact(sceneName: "Mercury", info: "The smallest planet and closest to the Sun, Mercury has extreme temperature shifts and a cratered surface, resembling Earth’s moon in appearance.")])]
}

struct Artifact: Identifiable {
    let sceneName: String
    let info: String
    var id: String {
        sceneName
    }
}
