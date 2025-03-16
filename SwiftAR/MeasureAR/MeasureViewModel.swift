//
//  MeasureViewModel.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 16.03.25.
//

import Foundation
import Combine

class MeasureViewModel: ObservableObject {
    @Published var currentMeasurement: MeasurementModel?
    
    func getFormattedDistance(distance: Float) -> String {
        var measurement = Measurement(value: Double(distance), unit: UnitLength.meters)
        measurement.convert(to: .centimeters)
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.unitOptions = .providedUnit
        return formatter.string(from: measurement)
    }
}
