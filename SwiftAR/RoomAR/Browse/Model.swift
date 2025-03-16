//
//  Model.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 15.03.25.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: String, Codable, CaseIterable {
    case table
    case chair
    case decor
    
    var title: String {
        switch self {
        case .table:
            "Tables"
        case .chair:
            "Chairs"
        case .decor:
            "Decor"
        }
    }
}

class Model: Codable {
    var name: String
    var category: ModelCategory
    private var image: String
    private var modelName: String
    var scaleCompensation: Float
    var modelEntity: ModelEntity?
    
    private enum CodingKeys: String, CodingKey {
        case name, category, image, modelName, scaleCompensation
    }
    
    var thumbnail: Image {
        Image(image)
    }
    
    @MainActor
    func loadModelAsync() async throws {
        modelEntity = try await ModelEntity(named: modelName)
        modelEntity?.scale *= scaleCompensation
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        do {
            let decoder = JSONDecoder()
            guard let url = Bundle.main.url(forResource: "models-data", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            all = try decoder.decode([Model].self, from: data)
        } catch { }
    }
    
    func get(category: ModelCategory) -> [Model] {
        all.filter { $0.category == category }
    }
}
