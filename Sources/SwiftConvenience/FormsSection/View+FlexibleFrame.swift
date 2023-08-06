//
//  View+FlexibleFrame.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func flexibleFrame(width: CGFloat?, height: CGFloat?) -> some View {
        if width == .infinity && height == .infinity {
            self
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if width == .infinity {
            self
                .frame(maxWidth: .infinity)
                .frame(height: height)
        } else if height == .infinity {
            self
                .frame(maxHeight: .infinity)
                .frame(width: width)
        } else {
            self
                .frame(width: width, height: height)
        }
    }
}
