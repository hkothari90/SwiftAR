//
//  MeasureView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 16.03.25.
//

import SwiftUI
import ARKit
import RealityKit

struct MeasureView: View {
    @StateObject var viewModel: MeasureViewModel
    @State private var shouldMarkMeasurementPoint = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer() { arView in
                guard let focusEntity = arView.focusEntity else { return }
                let focusTransform = focusEntity.transformMatrix(relativeTo: nil)
                let focusPosition = SIMD3<Float>(focusTransform.columns.3.x, focusTransform.columns.3.y, focusTransform.columns.3.z)

                if shouldMarkMeasurementPoint {
                    if viewModel.currentMeasurement == nil {
                        viewModel.currentMeasurement = .init(startPosition: focusPosition)
                    } else {
                        viewModel.currentMeasurement = nil
                    }
                    drawMeasurementPoint(at: focusPosition, in: arView)
                    shouldMarkMeasurementPoint = false
                }
                guard viewModel.currentMeasurement != nil else { return }
                viewModel.currentMeasurement?.endPosition = focusPosition
                drawLine(in: arView)
            }
            
            ControlButtonView(systemIconName: "plus.circle.fill") {
                self.shouldMarkMeasurementPoint.toggle()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func drawMeasurementPoint(at position: SIMD3<Float>, in arView: ARView) {
        let pointEntity = ModelEntity(mesh: .generateSphere(radius: 0.01), materials: [SimpleMaterial(color: .green, roughness: 1, isMetallic: false)])
        let pointAnchor = AnchorEntity()
        pointAnchor.position = position
        pointAnchor.addChild(pointEntity)
        arView.scene.addAnchor(pointAnchor)
    }
    
    private func drawLine(in arView: CustomARView) {
        guard let currentMeasurement = viewModel.currentMeasurement,
              let startPosition = currentMeasurement.startPosition,
              let endPosition = currentMeasurement.endPosition else { return }
        if let lineAnchor = arView.scene.findEntity(named: "line-\(currentMeasurement.id)") {
            arView.scene.removeAnchor(lineAnchor as! HasAnchoring)
        }

        let centerPosition = SIMD3(x:(startPosition.x + endPosition.x) / 2, y:(startPosition.y + endPosition.y) / 2, z:(startPosition.z + endPosition.z) / 2)
        let meters = simd_distance(startPosition, endPosition)
        let distanceText = viewModel.getFormattedDistance(distance: meters)
        
        let radians = -90.0 * Float.pi / 180
        let distanceEntity = ModelEntity(mesh: .generateText(distanceText, extrusionDepth: 0.005, font: .systemFont(ofSize: 0.03, weight: .bold)),
                                         materials: [SimpleMaterial(color: .green, roughness: 1, isMetallic: false)])
        distanceEntity.transform.rotation = simd_quatf(angle: radians, axis: SIMD3(x: 0, y: 1, z: 0))
        let lineEntity = ModelEntity(mesh: .generateBox(width:0.005, height: 0.005, depth: meters),
                                           materials: [SimpleMaterial(color: .green, roughness: 1, isMetallic: false)])

        let lineAnchor = AnchorEntity()
        lineAnchor.name = "line-\(currentMeasurement.id)"
        lineAnchor.addChild(distanceEntity)
        lineAnchor.addChild(lineEntity)
        lineAnchor.position = centerPosition
        lineAnchor.look(at: startPosition, from: centerPosition, relativeTo: nil)
        arView.scene.addAnchor(lineAnchor)
    }
}

#Preview {
    MeasureView(viewModel: MeasureViewModel())
}
