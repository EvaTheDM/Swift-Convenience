//
//  SheetToolbar.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct SheetToolbar<Content: View, Leading: View, Trailing: View>: View {
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    let content: AnyView?
    let leadingToolbar: AnyView?
    let trailingToolbar: AnyView?
    
    private init(_ content: Content?, leadingToolbar: Leading?, trailingToolbar: Trailing?) {
        self.content = content == nil ? nil : AnyView(content)
        self.leadingToolbar = leadingToolbar == nil ? nil : AnyView(leadingToolbar)
        self.trailingToolbar = trailingToolbar == nil ? nil : AnyView(trailingToolbar)
    }
    
    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder leading: @escaping () -> Leading, @ViewBuilder _ trailing: @escaping () -> Trailing) {
        self.init(content(), leadingToolbar: leading(), trailingToolbar: trailing())
    }
    
    public var body: some View {
        ZStack {
            HStack {
                if let leadingToolbar = leadingToolbar {
                    leadingToolbar
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                if let trailingToolbar = trailingToolbar {
                    trailingToolbar
                }
                TwoToneButton(.xmarkCircleFill, action: dismiss.callAsFunction)
            }
            
            content
                .font(.headline)
        }
    }
}

public extension SheetToolbar where Content == Text {
    init(_ title: String, @ViewBuilder leading: @escaping () -> Leading, @ViewBuilder trailing: @escaping () -> Trailing) {
        self.init(Text(title), leadingToolbar: leading(), trailingToolbar: trailing())
    }
}

public extension SheetToolbar where Content == Text, Leading == EmptyView, Trailing == EmptyView {
    init(_ title: String) {
        self.init(Text(title), leadingToolbar: nil, trailingToolbar: nil)
    }
}

public extension SheetToolbar where Leading == EmptyView, Trailing == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.init(content(), leadingToolbar: nil, trailingToolbar: nil)
    }
}

public extension SheetToolbar where Leading == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder trailing: @escaping () -> Trailing) {
        self.init(content(), leadingToolbar: nil, trailingToolbar: trailing())
    }
}

public extension SheetToolbar where Leading == EmptyView, Content == Text {
    init(_ title: String, @ViewBuilder trailing: @escaping () -> Trailing) {
        self.init(Text(title), leadingToolbar: nil, trailingToolbar: trailing())
    }
}

public extension SheetToolbar where Trailing == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder leading: @escaping () -> Leading) {
        self.init(content(), leadingToolbar: leading(), trailingToolbar: nil)
    }
}

public extension SheetToolbar where Trailing == EmptyView, Content == Text {
    init(_ title: String, @ViewBuilder leading: @escaping () -> Leading) {
        self.init(Text(title), leadingToolbar: leading(), trailingToolbar: nil)
    }
}
