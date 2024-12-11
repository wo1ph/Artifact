# *AR*tifact

Demo vid: https://youtu.be/73dV2QORRS4

ARtifact is an education technology app that allows students to learn in an immersive way. Students can journey into a variety of topics and bring 3D “Artifacts” right into their space. Artifact is (very) inspired by Expeditions, Google’s discontinued virtual and augmented reality field trip app.

Many educational experiences lack engagement, especially for students who benefit from a more visual and hands-on learning environment. Artifact aims to help solve this problem by bringing historical and scientific concepts to life - making learning fun, interactive, and accessible to students of various learning styles. Imagine students being able to tour the Roman Colosseum, explore the solar sytem, or visualize a chemical structure all within their classroom or even at home. The possibilities are endless! 

- [x] Splash screen
- [x] Onboarding screen
- [x] Custom App Icon
- [x] At least one animation
  - Small animations throughout, e.g. Journey detail view animates the header when it is opened
- [x] At least one scrollable list
  - Main content view has a list of Journeys
- [x] Some form of navigation
  - Uses `NavigationStack`
- [x] One or more network calls
  - Makes network calls to get Journey data
- [ ] No packages - **App does use a RealityComposer package, but I built it**
- [x] The app stores data on device
  - Uses `UserDefaults` to persist tracking how many ARtifacts were viewed in a Journey
- [x] The app uses Swift modern concurrency
 - Uses `async/await` and `Task` for networking and loading of 3D scenes
- [x] Use an API of your choosing
 - Uses a Journey API I built in AWS with API Gateway and a Lambda
- [x] All typical errors related to network calls are handled
  - Uses `try` and `throws`
- [x] The code should follow a MVVM architecture
  - Uses a viewmodel to manage fetching Journey data, and another viewmodel to manage loading 3D scenes

# Original Kodeco capstone proposal

## MVP Features

###### What I plan to focus on for the capstone

- A user can open the home screen on the discover tab to see a list of “Journeys”, or topics they can explore **(URLSession)**.
- A user can favorite a Journey and see a list of their favorites on the favorites tab of the home screen **(UserDefaults for data persistence)**.
- A user can click a Journey to open a detail sheet with more information about the journey.
- A user can click a start button to open an augmented reality experience. The Journey will have 3D Artifacts related to the given topic **(SwiftUI Navigation, RealityKit/ARKit)**.
- A user can navigate through the Artifacts in the Journey.
- A user can pull up a sheet with information about the selected Artifact.
- A user can exit the Journey to go back to the home screen.

## Notes
- I’d really like to use AWS in my app if possible (or Firebase alternatively) to store images, 3D models, and for a Journey API.
- I'm planning to just focus on one Journey for the MVP. Will consider adding more and other features with extra time.

## Conceptual Images

###### Taken from Google Expeditions AR, which this app will be a clone of. 

<div>
  <img width="385" alt="Screenshot 2024-10-09 at 11 47 47 PM" src="https://github.com/user-attachments/assets/05bd3137-06fc-4630-9446-9cbdd66d9e27">
</div>
<div>
  <img width="340" alt="Screenshot 2024-10-09 at 11 42 11 PM" src="https://github.com/user-attachments/assets/26de324f-3419-4d57-9251-67f2e9032110">
</div>
