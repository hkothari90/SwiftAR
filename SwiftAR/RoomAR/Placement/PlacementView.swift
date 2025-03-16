//
//  PlacementView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 15.03.25.
//

import SwiftUI

struct PlacementView: View {
    @Binding var selectedModel: Model?
    @Binding var confirmedModel: Model?

    var body: some View {
        HStack {
            Spacer()
            
            PlacementButton(systemIconName: "xmark.circle.fill") {
                self.selectedModel = nil
            }
            
            Spacer()

            PlacementButton(systemIconName: "checkmark.circle.fill") {
                self.confirmedModel = self.selectedModel
                self.selectedModel = nil
            }
            
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct PlacementButton: View {
    @Environment(\.colorScheme) var colorScheme

    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}

#Preview {
    PlacementView(selectedModel: .constant(nil), confirmedModel: .constant(nil))
}
