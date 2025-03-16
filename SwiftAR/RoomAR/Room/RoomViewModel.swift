//
//  RoomViewModel.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 16.03.25.
//

import Combine

class RoomViewModel: ObservableObject {
    @Published var selectedModel: Model?
    
    @Published var confirmedModel: Model?
}
