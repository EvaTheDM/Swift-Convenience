//
//  Card.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct CardIcon {
    let icon: SFSymbols
    let size: CGFloat
    let offset: (x: CGFloat, y: CGFloat)
}

public struct Card<Content: View>: View {
    let content: Content
    let backgroundColor: Color
    let foregroundColor: Color
    let size: (CGFloat?, CGFloat?)
    let icon: CardIcon?
    
    public init(icon: CardIcon? = nil, background: Color = .systemGray6, foreground: Color = .label, size: (CGFloat?, CGFloat?) = (nil, nil), @ViewBuilder _ content: () -> Content) {
        self.backgroundColor = background
        self.foregroundColor = foreground
        self.size = size
        self.content = content()
        self.icon = icon
    }
    
    public var body: some View {
        Group {
            if let icon = icon {
                contentCard
                    .background(withIcon(icon))
                    .background(backgroundColor)
                    .cornerRadius(15)
            } else {
                contentCard
                    .background(backgroundColor)
                    .cornerRadius(15)
            }
        }
        .foregroundColor(foregroundColor)
    }
    
    func withIcon(_ icon: CardIcon) -> some View {
        Image(sfSymbol: icon.icon)
            .resizableIcon(icon.size)
            .fontWeight(.black)
            .offset(x: icon.offset.x, y: icon.offset.y)
            .flexibleFrame(width: size.0, height: size.1)
            .clipped()
            .opacity(0.2)
    }
    
    var contentCard: some View {
        content
            .flexibleFrame(width: size.0, height: size.1)
            .cornerRadius(15)
    }
}
