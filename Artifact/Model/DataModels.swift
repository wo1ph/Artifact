struct Journey {
    let imageUrl: String
    let title: String
    let description: String
    let artifactPrefix: String
    let artifacts: [Artifact]
    
    static let sampleJourneys = [Journey(imageUrl: "https://artifact-ios.s3.us-east-2.amazonaws.com/7.jpg", title: "7 wonders", description: "Embark on a journey to explore the legendary New 7 Wonders of the World, marvels that span continents and time. From the ancient walls that stretch across China to the towering statue overlooking Rio, each wonder tells a story of human achievement and cultural legacy. Encounter the architectural splendor of Petra, the timeless beauty of the Taj Mahal, and the majestic terraces of Machu Picchu. Stand before the enduring grandeur of Chichen Itza and the epic arches of the Roman Colosseum. This journey isn’t just about visiting places—it’s a path through history, mystery, and the extraordinary tales behind the world’s most iconic structures. Let each wonder inspire awe, ignite curiosity, and deepen your connection to the world’s shared heritage.", artifactPrefix: "7", artifacts: [Artifact(sceneName: "Colosseum"), Artifact(sceneName: "Great_Wall"), Artifact(sceneName: "Petra"), Artifact(sceneName: "Christ_the_Redeemer"), Artifact(sceneName: "Machu_Picchu"), Artifact(sceneName: "Taj_Mahal"), Artifact(sceneName: "Chichen_Itza")])]
}

struct Artifact: Identifiable {
    let sceneName: String
    var id: String {
        sceneName
    }
}
