//
//  BrowseView.swift
//  SwiftAR
//
//  Created by Hardik Kothari on 15.03.25.
//

import SwiftUI

struct BrowseView: View {
    @Binding var showBrowse: Bool
    @Binding var selectedModel: Model?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ModelsByCategoryGrid(showBrowse: $showBrowse, selectedModel: $selectedModel)
            }
            .navigationBarTitle(Text("Browse"), displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showBrowse.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}

struct ModelsByCategoryGrid: View {
    @Binding var showBrowse: Bool
    @Binding var selectedModel: Model?

    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id: \.self) { category in
                let modelsByCategory = models.get(category: category)
                if !modelsByCategory.isEmpty {
                    HorizontalGrid(title: category.title, items: modelsByCategory, showBrowse: $showBrowse, selectedModel: $selectedModel)
                }
            }
        }
    }
}

struct HorizontalGrid: View {
    @Environment(\.colorScheme) var colorScheme

    var title: String
    var items: [Model]
    @Binding var showBrowse: Bool
    @Binding var selectedModel: Model?

    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading) {
            Separator()
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 24)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    ForEach(items, id:\.name) { model in
                        ItemButton(model: model) {
                            Task {
                                try await model.loadModelAsync()
                            }
                            self.selectedModel = model
                            self.showBrowse = false
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
            }
            .background(colorScheme == .dark ? .white.opacity(0.05) : .black.opacity(0.05))
        }
    }
}

struct ItemButton: View {
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            model.thumbnail
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(.secondary)
                .cornerRadius(8)
        }
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}

#Preview {
    BrowseView(showBrowse: .constant(false), selectedModel: .constant(nil))
}
