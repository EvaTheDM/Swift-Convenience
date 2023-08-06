//
//  MutableSection.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct MutableSection<Data, Content>: View where Data: RandomAccessCollection, Data: MutableCollection, Data.Element: Identifiable, Content: View {
    @Binding var data: Data
    let content: (Binding<Data.Element>) -> Content
    let label: String
    let addEntry: () -> Void
    let allowMove: Bool
    let moveCompletion: (() -> Void)?
    let delete: ((IndexSet) -> Void)?
    
    public init(_ title: String, data: Binding<Data>, @ViewBuilder content: @escaping (Binding<Data.Element>) -> Content, addEntry: @escaping () -> Void, allowMove: Bool = true, moveCompletion: (() -> Void)? = nil, delete: ((IndexSet) -> Void)? = nil) {
        self.label = title
        self._data = data
        self.content = content
        self.addEntry = addEntry
        self.allowMove = allowMove
        self.moveCompletion = moveCompletion
        self.delete = delete
    }
    
    public var body: some View {
        Section {
            if allowMove && delete == nil {
                ForEach($data, id: \.id, content: content)
                    .onMove(perform: move)
            } else if allowMove, let delete = delete {
                ForEach($data, id: \.id, content: content)
                    .onMove(perform: move)
                    .onDelete(perform: delete)
            } else if !allowMove, let delete = delete {
                ForEach($data, id: \.id, content: content)
                    .onDelete(perform: delete)
            } else {
                ForEach($data, id: \.id, content: content)
            }
        } header: {
            HStack {
                Text(label)
                Spacer()
                Button(action: addEntry) {
                    Image(sfSymbol: .plus)
                }
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        data.move(fromOffsets: source, toOffset: destination)
        if let moveCompletion = moveCompletion {
            moveCompletion()
        }
    }
}
