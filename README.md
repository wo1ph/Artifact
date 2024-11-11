# Capstone Checkpoints 2 and 3 Submission

Original capstone proposal: [https://github.com/wo1ph/kodeco-capstone-proposal/tree/proposal](https://github.com/wo1ph/kodeco-capstone-proposal/pull/1)

# Kodeco capstone proposal

## *AR*tifact

ARtifact is an education technology app that allows students to learn in an immersive way. Students can journey into a variety of topics and bring 3D “Artifacts” right into their space. Artifact is (very) inspired by Expeditions, Google’s discontinued virtual and augmented reality field trip app.

Many educational experiences lack engagement, especially for students who benefit from a more visual and hands-on learning environment. Artifact aims to help solve this problem by bringing historical and scientific concepts to life - making learning fun, interactive, and accessible to students of various learning styles. Imagine students being able to tour the Roman Colosseum, explore the solar sytem, or visualize a chemical structure all within their classroom or even at home. The possibilities are endless!

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
