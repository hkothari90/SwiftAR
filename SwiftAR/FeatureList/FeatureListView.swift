//
//  FeatureListView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 14.03.25.
//

import SwiftUI

enum Feature: String, CaseIterable {
    case measureAR, roomAR
    
    var iconName: String {
        switch self {
        case .roomAR:
            return "ic_place_ar"
        case .measureAR:
            return "ic_measure_ar"
        }
    }
    
    var title: String {
        switch self {
        case .roomAR:
            return "RoomAR"
        case .measureAR:
            return "MeasureAR"
        }
    }
}

struct FeatureListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationSplitView {
            List(Feature.allCases, id: \.rawValue) { feature in
                NavigationLink {
                    switch feature {
                    case .roomAR:
                        RoomView(viewModel: RoomViewModel())
                    case .measureAR:
                        MeasureView(viewModel: MeasureViewModel())
                    }
                } label: {
                    FeatureListItemView(item: feature)
                }
            }
            .navigationTitle("SwiftAR")
            .listStyle(.grouped)
        } detail: {
            Text("Select a Feature")
        }
        .background(colorScheme == .dark ? .black : .white)
    }
}

#Preview {
    FeatureListView()
}
