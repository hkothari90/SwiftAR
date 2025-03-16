//
//  FeatureListItemView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 14.03.25.
//

import SwiftUI

struct FeatureListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let item: Feature
    
    var body: some View {
        HStack {
            Image(item.iconName)
                .renderingMode(.template)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Text(item.title)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.leading, 8)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FeatureListItemView(item: .measureAR)
}
