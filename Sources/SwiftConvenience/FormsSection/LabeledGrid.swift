//
//  LabeledGrid.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct LabeledGrid: View {
    let label: String
    let content: AnyView
    let grid: GridInfo
    
    public init<Content: View>(_ label: String, grid: GridInfo = GridInfo(), @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = AnyView(content())
        self.grid = grid
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title2)
                .fontWeight(.semibold)
            
            Grid(alignment: grid.alignment, horizontalSpacing: grid.horizontalSpacing, verticalSpacing: grid.verticalSpacing) {
                content
            }
        }
    }
}

public struct GridInfo {
    let alignment: Alignment
    let horizontalSpacing: CGFloat?
    let verticalSpacing: CGFloat?

    public init(alignment: Alignment = .center, horizontalSpacing: CGFloat? = nil, verticalSpacing: CGFloat? = nil) {
        self.alignment = alignment
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
}

public extension LabeledGrid {
    init<Data: RandomAccessCollection, ID: Hashable, Content: View>(_ label: String, grid: GridInfo = GridInfo(), data: Data, identityKeyPath: KeyPath<Data.Element, ID>, rowAction: ((Data.Element) -> Void)? = nil, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.init(label, grid: grid) {
            ForEach(data, id: identityKeyPath) { element in
                if let rowAction = rowAction {
                    GridRow { content(element) }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                rowAction(element)
                            }
                        }
                } else {
                    GridRow { content(element) }
                }
            }
        }
    }
    
    init<Data: RandomAccessCollection, Content: View>(_ label: String, grid: GridInfo = GridInfo(), data: Data, rowAction: ((Data.Element) -> Void)? = nil, @ViewBuilder content: @escaping (Data.Element) -> Content) where Data.Element: Identifiable {
        self.init(label, grid: grid) {
            ForEach(data, id: \.id) { element in
                if let rowAction = rowAction {
                    GridRow { content(element) }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                rowAction(element)
                            }
                        }
                } else {
                    GridRow { content(element) }
                }
            }
        }
    }
}
