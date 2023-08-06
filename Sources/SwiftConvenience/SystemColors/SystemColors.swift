//
//  SystemColors.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

#if canImport(SwiftUI)
import SwiftUI

#if canImport(UIKit)
import UIKit
private typealias PlatformColor = UIColor
#elseif canImport(AppKit)
import AppKit
private typealias PlatformColor = NSColor
#endif

#if !os(watchOS)

public extension Color {
    init(light: Color, contrastLight: Color? = nil, dark: Color, contrastDark: Color? = nil) {
        #if canImport(UIKit)
        self.init(light: UIColor(light), contrastLight: UIColor(contrastLight ?? light), dark: UIColor(dark), contrastDark: UIColor(contrastDark ?? dark))
        #else
        self.init(light: NSColor(light), contrastLight: NSColor(contrastLight ?? light), dark: NSColor(dark), contrastDark: NSColor(contrastDark ?? dark))
        #endif
    }
    
    fileprivate init(_ rgb: (Double, Double, Double)) {
        self.init(red: rgb.0, green: rgb.1, blue: rgb.2)
    }
    fileprivate init(_ redGreen: Double, _ blue: Double) {
        self.init(red: redGreen, green: redGreen, blue: blue)
    }
    
    fileprivate init(light: PlatformColor, contrastLight: PlatformColor, dark: PlatformColor, contrastDark: PlatformColor) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor(dynamicProvider: { traits in
            let contrast = traits.accessibilityContrast
            
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return contrast == .high ? contrastLight : light
            case .dark:
                return contrast == .high ? contrastDark : dark
            @unknown default:
                assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                return contrast == .high ? contrastLight : light
            }
        }))
        #elseif canImport(AppKit)
        self.init(nsColor: NSColor(name: nil, dynamicProvider: { appearance in
            switch appearance.name {
            case .aqua, .vibrantLight:
                return light
            case .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight:
                return contrastLight
            case .darkAqua, .vibrantDark:
                return dark
            case .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantDark:
                return contrastDark
            default:
                assertionFailure("Unknown appearance: \(appearance.name)")
                return light
            }
        }))
        #endif
    }
}

public extension Color {
    static var systemRed: Color { Color(PlatformColor.systemRed) }
    static var systemOrange: Color { Color(PlatformColor.systemOrange) }
    static var systemYellow: Color { Color(PlatformColor.systemYellow) }
    static var systemGreen: Color { Color(PlatformColor.systemGreen) }
    static var systemMint: Color { Color(PlatformColor.systemMint) }
    static var systemTeal: Color { Color(PlatformColor.systemTeal) }
    static var systemCyan: Color { Color(PlatformColor.systemCyan) }
    static var systemBlue: Color { Color(PlatformColor.systemBlue) }
    static var systemIndigo: Color { Color(PlatformColor.systemIndigo) }
    static var systemPurple: Color { Color(PlatformColor.systemPurple) }
    static var systemPink: Color { Color(PlatformColor.systemPink) }
    static var systemBrown: Color { Color(PlatformColor.systemBrown) }
    static var systemGray: Color { Color(PlatformColor.systemGray) }
    
    static var darkGray: Color { Color(PlatformColor.darkGray) }
    static var lightGray: Color { Color(PlatformColor.lightGray) }
    static var magenta: Color { Color(PlatformColor.magenta) }
}

#if canImport(UIKit) && !os(tvOS)
public extension Color {
    static var systemGray2: Color { Color(PlatformColor.systemGray2) }
    static var systemGray3: Color { Color(PlatformColor.systemGray3) }
    static var systemGray4: Color { Color(PlatformColor.systemGray4) }
    static var systemGray5: Color { Color(PlatformColor.systemGray5) }
    static var systemGray6: Color { Color(PlatformColor.systemGray6) }
}
#endif // canImport(UIKit) && !os(tvOS)

#if canImport(AppKit) && os(macOS)
public extension Color {
    static var systemGray2: Color { Color(
        light: Color(174, 178),
        contrastLight: Color(142, 147),
        dark: Color(99, 102),
        contrastDark: Color(124, 128)
    ) }
    static var systemGray3: Color { Color(
        light: Color(199, 204),
        contrastLight: Color(174, 178),
        dark: Color(72, 74),
        contrastDark: Color(84, 86)
    ) }
    static var systemGray4: Color { Color(
        light: Color(209, 214),
        contrastLight: Color(188, 192),
        dark: Color(58, 60),
        contrastDark: Color(68, 60)
    ) }
    static var systemGray5: Color { Color(
        light: Color(229, 234),
        contrastLight: Color(216, 220),
        dark: Color(44, 46),
        contrastDark: Color(54, 56)
    ) }
    static var systemGray6: Color { Color(
        light: Color(242, 247),
        contrastLight: Color(235, 240),
        dark: Color(28, 30),
        contrastDark: Color(36, 38)
    ) }
}
#endif // canImport(AppKit) && os(macOS)

#if canImport(UIKit)
public extension Color {
    // MARK: - LABEL COLORS
    static var label: Color { Color(PlatformColor.label) }
    static var secondaryLabel: Color { Color(PlatformColor.secondaryLabel) }
    static var tertiaryLabel: Color { Color(PlatformColor.tertiaryLabel) }
    static var quaternaryLabel: Color { Color(PlatformColor.quaternaryLabel) }

    // MARK: - FILL COLORS
    static var systemFill: Color { Color(PlatformColor.systemFill) }
    static var secondarySystemFill: Color { Color(PlatformColor.secondarySystemFill) }
    static var tertiarySystemFill: Color { Color(PlatformColor.tertiarySystemFill) }
    static var quaternarySystemFill: Color { Color(PlatformColor.quaternarySystemFill) }

    // MARK: - TEXT COLORS
    static var placeholderText: Color { Color(PlatformColor.placeholderText) }

    // MARK: - STANDARD CONTENT BACKGROUND COLORS
    static var systemBackground: Color { Color(PlatformColor.systemBackground) }
    static var secondarySystemBackground: Color { Color(PlatformColor.secondarySystemBackground) }
    static var tertiarySystemBackground: Color { Color(PlatformColor.tertiarySystemBackground) }

    // MARK: - GROUPED CONTENT BACKGROUND COLORS
    static var systemGroupedBackground: Color { Color(PlatformColor.systemGroupedBackground) }
    static var secondarySystemGroupedBackground: Color { Color(PlatformColor.secondarySystemGroupedBackground) }
    static var tertiarySystemGroupedBackground: Color { Color(PlatformColor.tertiarySystemGroupedBackground) }

    // MARK: - SEPERATOR COLORS
    static var separator: Color { Color(PlatformColor.separator) }
    static var opaqueSeparator: Color { Color(PlatformColor.opaqueSeparator) }
    
    // MARK: - LINK COLOR
    static var link: Color { Color(PlatformColor.link) }

    // MARK: - NONADAPTABLE COLORS
    static var darkText: Color { Color(PlatformColor.darkText) }
    static var lightText: Color { Color(PlatformColor.lightText) }
}
#elseif canImport(AppKit)
public extension Color {
    // MARK: - LABEL COLORS
    static var label: Color { Color(PlatformColor.labelColor) }
    static var secondaryLabel: Color { Color(PlatformColor.secondaryLabelColor) }
    static var tertiaryLabel: Color { Color(PlatformColor.tertiaryLabelColor) }
    static var quaternaryLabel: Color { Color(PlatformColor.quaternaryLabelColor) }

    // MARK: - TEXT COLORS
    static var text: Color { Color(PlatformColor.textColor) }
    static var placeholderText: Color { Color(PlatformColor.placeholderTextColor) }
    static var selectedText: Color { Color(PlatformColor.selectedTextColor) }
    static var textBackground: Color { Color(PlatformColor.textBackgroundColor) }
    static var selectedTextBackground: Color { Color(PlatformColor.selectedTextBackgroundColor) }
    static var keyboardFocusIndicator: Color { Color(PlatformColor.keyboardFocusIndicatorColor) }
    static var unemphasizedSelectedText: Color { Color(PlatformColor.unemphasizedSelectedTextColor) }
    static var unemphasizedSelectedTextBackground: Color { Color(PlatformColor.unemphasizedSelectedTextBackgroundColor) }

    // MARK: - CONTENT COLORS
    static var link: Color { Color(PlatformColor.linkColor) }
    static var separator: Color { Color(PlatformColor.separatorColor) }
    static var selectedContentBackground: Color { Color(PlatformColor.selectedContentBackgroundColor) }
    static var unemphasizedSelectedContentBackground: Color { Color(PlatformColor.unemphasizedSelectedContentBackgroundColor) }

    // MARK: - MENU COLORS
    static var selectedMenuItemText: Color { Color(PlatformColor.selectedMenuItemTextColor) }

    // MARK: - TABLE COLORS
    static var grid: Color { Color(PlatformColor.gridColor) }
    static var headerText: Color { Color(PlatformColor.headerTextColor) }
    static var alternatingContentBackgroundColors: [Color] { PlatformColor.alternatingContentBackgroundColors.map(Color.init) }

    // MARK: - CONTROL COLORS
    static var controlAccent: Color { Color(PlatformColor.controlAccentColor) }
    static var control: Color { Color(PlatformColor.controlColor) }
    static var controlBackground: Color { Color(PlatformColor.controlBackgroundColor) }
    static var controlText: Color { Color(PlatformColor.controlTextColor) }
    static var disabledControlText: Color { Color(PlatformColor.disabledControlTextColor) }
    static var selectedControl: Color { Color(PlatformColor.selectedControlColor) }
    static var selectedControlText: Color { Color(PlatformColor.selectedControlTextColor) }
    static var alternateSelectedControlText: Color { Color(PlatformColor.alternateSelectedControlTextColor) }
    static var scrubberTexturedBackground: Color { Color(PlatformColor.scrubberTexturedBackground) }

    // MARK: - WINDOW COLORS
    static var windowBackground: Color { Color(PlatformColor.windowBackgroundColor) }
    static var windowFrameText: Color { Color(PlatformColor.windowFrameTextColor) }
    static var underPageBackground: Color { Color(PlatformColor.underPageBackgroundColor) }

    // MARK: - HIGHLIGHTS AND SHADOWS
    static var findHighlight: Color { Color(PlatformColor.findHighlightColor) }
    static var highlight: Color { Color(PlatformColor.highlightColor) }
    static var shadow: Color { Color(PlatformColor.shadowColor) }
}
#endif

#endif // !os(watchOS)
#endif // canImport(SwiftUI)
