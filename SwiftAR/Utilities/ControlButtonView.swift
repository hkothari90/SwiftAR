//
//  ControlButtonView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 16.03.25.
//

import SwiftUI

struct ControlButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button( action: {
                action()
            }) {
                Image(systemName: systemIconName)
                    .font(.system(size: 40))
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                    .buttonStyle(PlainButtonStyle())
            }
            .frame(width: 50, height: 50)
        }
        .frame(maxWidth: 500)
        .padding(20)
        .background(colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25))
    }
}

#Preview {
    ControlButtonView(systemIconName: "square.grid.2x2") {}
}
