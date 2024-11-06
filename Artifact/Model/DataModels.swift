struct Journey {
    let imageUrl: String
    let title: String
    let description: String
    let artifactPrefix: String
    let artifacts: [Artifact]
    
    static let sampleJourneys = [Journey(imageUrl: "https://artifact-ios.s3.us-east-2.amazonaws.com/roma.jpg", title: "Ancient Rome", description: "Ancient Rome was one of the greatest civilizations in history, known for its incredible architecture, political system, and vast empire. Visitors can explore famous landmarks such as the Colosseum, the Roman Forum, and the Pantheon, and learn about the lives of emperors, gladiators, and citizens. This journey offers a glimpse into the culture, innovations, and enduring legacy of Rome, highlighting its contributions to law, art, and engineering.", artifactPrefix: "Roma", artifacts: [Artifact(sceneName: "Colosseum"), Artifact(sceneName: "Trevi")])]
}

struct Artifact: Identifiable {
    let sceneName: String
    var id: String {
        sceneName
    }
}
