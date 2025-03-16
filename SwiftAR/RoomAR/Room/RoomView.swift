//
//  RoomView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 14.03.25.
//

import SwiftUI
import ARKit
import RealityKit

struct RoomView: View {
    @StateObject var viewModel: RoomViewModel
    @State private var showBrowse = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer() { arView in
                arView.focusEntity?.isEnabled = viewModel.selectedModel != nil
                if let confirmedModel = viewModel.confirmedModel, let modelEntity = confirmedModel.modelEntity {
                    place(modelEntity, in: arView)
                    viewModel.confirmedModel = nil
                }
            }
            
            if viewModel.selectedModel != nil {
                PlacementView(selectedModel: $viewModel.selectedModel, confirmedModel: $viewModel.confirmedModel)
            } else {
                ControlButtonView(systemIconName: "square.grid.2x2") {
                    self.showBrowse.toggle()
                }
            }
        }
        .sheet(isPresented: $showBrowse, content: {
            BrowseView(showBrowse: $showBrowse, selectedModel: $viewModel.selectedModel)
        })
        .edgesIgnoringSafeArea(.all)
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: CustomARView) {
        guard let focusEntity = arView.focusEntity else { return }

        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation], for: clonedEntity)
        for animation in clonedEntity.availableAnimations {
            clonedEntity.playAnimation(animation.repeat(duration: .infinity), transitionDuration: 1.25, startsPaused: false)
        }
        
        let focusTransform = focusEntity.transformMatrix(relativeTo: nil)
        let modelAnchor = AnchorEntity(world: focusTransform)
        modelAnchor.addChild(clonedEntity)
        arView.scene.addAnchor(modelAnchor)
    }
}

#Preview {
    RoomView(viewModel: RoomViewModel())
}
