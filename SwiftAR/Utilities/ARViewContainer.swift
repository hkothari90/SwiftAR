//
//  ARViewContainer.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 14.03.25.
//

import SwiftUI
import ARKit
import RealityKit
import FocusEntity
import Combine

struct ARViewContainer: UIViewRepresentable {
    let onSceneUpdate: ((CustomARView) -> Void)
    
    func makeUIView(context: Context) -> CustomARView {
        let customARView = CustomARView(frame: .zero)
        customARView.sceneObserver = customARView.scene.subscribe(to: SceneEvents.Update.self, { event in
            self.updateScene(for: customARView)
        })
        return customARView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) { }
    
    private func updateScene(for customARView: CustomARView) {
        onSceneUpdate(customARView)
    }
}

class CustomARView: ARView {
    var sceneObserver: Cancellable?
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusEntity = FocusEntity(on: self, focus: .classic)
        configure()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        environment.sceneUnderstanding.options.insert(.occlusion)
        session.run(config)
    }
}
