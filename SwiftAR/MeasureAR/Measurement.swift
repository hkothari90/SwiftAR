//
//  Measurement.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 16.03.25.
//

import Foundation

struct MeasurementModel: Identifiable {
    var id: UUID
    var startPosition: SIMD3<Float>?
    var endPosition: SIMD3<Float>?
    
    init(startPosition: SIMD3<Float>) {
        self.id = UUID()
        self.startPosition = startPosition
    }
}
