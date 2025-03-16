# SwiftAR

An **iOS** project that integrates **ARKit**, **RealityKit**, and **SwiftUI** to create an immersive augmented reality experience. This project demonstrates **3D model placement**, object interactions, measure length / height of objects and a modern SwiftUI-based UI.

## Features
![Demo](https://github.com/user-attachments/assets/f5d13846-d22e-4c8a-87b0-52aa2390edde)

### MeasureAR
- **Measurement Feature**: Measure real-world distances and length/height of real world objects.
- **AR Model Placement**: Drag and drop 3D objects into the real world.

### RoomAR
- **AR Model Placement**: Drag and drop 3D objects into the real world.
- **Gesture Interactions**: Move and rotate models with gestures.
- **RealityKit Rendering**: High-performance rendering with RealityKit.
- **SwiftUI UI Overlay**: Modern SwiftUI interface for controls.

## Requirements

- **Xcode 15+**
- **iOS 17+**
- **Swift 5.9+**
- **A device with A12 Bionic chip or later** (for AR capabilities)

## Dependencies

This project uses the following dependencies:

- ARKit – Apple's framework for augmented reality experiences.
- RealityKit – Apple's framework for rendering and simulating 3D content.
- SwiftUI – Declarative UI framework for iOS development.
- Combine – Apple's reactive programming framework for data binding.
- FocusEntity – A third-party Swift package that provides a focus indicator for placing AR objects.

## Installing FocusEntity

FocusEntity can be installed using Swift Package Manager (SPM):

1. Open your project in Xcode.
2. Go to File > Add Packages....
3. Enter the URL: https://github.com/maxxfrazer/FocusEntity.
4. Choose the latest stable version and add it to your project.

## Usage

1. Launch the app and grant **camera permissions**.
2. Scan your surroundings to detect a surface.
3. Tap to place a **3D model**. 3D models (.usdz) are included with the source-code. You can add your own with appropriate thumbnail and add them to **models-data.json** file.
4. Use gestures to **move or rotate** the model.
5. Activate the Measurement Tool to measure real-world distances.
6. The FocusEntity package provides a visual indicator to assist with object placement.

## Technologies Used

- **ARKit** – Handles world tracking and surface detection.
- **RealityKit** – Renders 3D models and animations.
- **SwiftUI** – Provides a clean and modern UI.
- **Combine** – Manages reactive UI updates.
- **FocusEntity** – Improves user experience with an AR focus indicator.

## License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.
