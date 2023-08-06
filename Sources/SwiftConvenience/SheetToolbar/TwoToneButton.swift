//
//  TwoToneButton.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct TwoToneButton: View {
    let symbol: SFSymbols
    let action: (() -> Void)?
    let destination: AnyView?
    let primaryColor: Color
    let secondaryColor: Color
    
    
    private init(symbol: SFSymbols, action: (() -> Void)?, destination: AnyView?, primaryColor: Color?, secondaryColor: Color?) {
        self.symbol = symbol
        self.action = action
        self.destination = destination
        self.primaryColor = primaryColor ?? Color.systemGray
        #if canImport(UIKit)
        self.secondaryColor = secondaryColor ?? Color.systemGray5
        #else
        self.secondaryColor = secondaryColor ?? Color.lightGray
        #endif
    }
    
    public init(_ symbol: SFSymbols, primaryColor: Color? = nil, secondaryColor: Color? = nil, action: @escaping () -> Void) {
        self.init(symbol: symbol, action: action, destination: nil, primaryColor: primaryColor, secondaryColor: secondaryColor)
    }
    
    public init<Destination: View>(_ symbol: SFSymbols, primaryColor: Color? = nil, secondaryColor: Color? = nil, destination: Destination) {
        self.init(symbol: symbol, action: nil, destination: AnyView(destination), primaryColor: primaryColor, secondaryColor: secondaryColor)
    }
    
    public var body: some View {
        if action != nil { asButton }
        else { asNavigation }
    }
    
    var buttonImage: some View {
        Image(sfSymbol: symbol)
            .resizableIcon(30)
            .symbolRenderingMode(.palette)
            .foregroundStyle(primaryColor, secondaryColor)
    }
    
    var asButton: some View {
        Button(action: action!) {
            buttonImage
        }
    }
    
    var asNavigation: some View {
        NavigationLink(destination: { destination! }) {
            buttonImage
        }
    }
}
