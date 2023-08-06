//
//  Checkbox.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct Checkbox: View {
    @Binding var value: Bool
    let label: String?
    let alignment: HorizontalAlignment
    
    public init(value: Binding<Bool>, label: String? = nil, labelAlignment: HorizontalAlignment = .trailing) {
        self._value = value
        self.label = label
        self.alignment = labelAlignment
    }
    
    public var body: some View {
        HStack {
            if alignment == .leading { textLabel }
            Image(sfSymbol: value ? .checkmarkSquare : .square)
                .onTapGesture {
                    withAnimation {
                        value.toggle()
                    }
                }
            if alignment == .trailing { textLabel }
        }
    }
    
    @ViewBuilder
    var textLabel: some View {
        if let label = label {
            Text(label)
                .font(.caption)
        }
    }
}
