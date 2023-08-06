//
//  SFSymbolPicker.swift
//  
//
//  Created by Janin Reinicke on 06.08.23.
//

import SwiftUI

public struct SFSymbolPicker: View {
    @Binding var selection: SFSymbols
    
    @State private var showPicker: Bool = false
    
    let label: String
    
    
    public init(text: String, selection: Binding<SFSymbols>) {
        self._selection = selection
        self.label = text
    }
    
    public var body: some View {
        Button(action: togglePicker) { selectedIcon }
            .sheet(isPresented: $showPicker) {
                PickerFrame(selection: $selection, showPicker: $showPicker)
            }
    }
    
    var selectedIcon: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.systemGray5)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30)
            .overlay {
                Image(sfSymbol: selection)
            }
            .foregroundColor(.label)
    }
    
    func togglePicker() {
        withAnimation {
            showPicker.toggle()
        }
    }
}

fileprivate struct PickerFrame: View {
    @Binding var selection: SFSymbols
    @Binding var showPicker: Bool
    
    @State private var searchBar: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            toolbar
            searchbarField
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 8)) {
                    ForEach(filteredIcons, id: \.rawValue, content: card)
                }
            }
        }
        .padding()
        .presentationDetents([.fraction(0.87)])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.systemGray6)
    }
    
    var toolbar: some View {
        HStack {
            Spacer()
            Button(action: { showPicker.toggle() }) {
                Image(sfSymbol: .xmarkCircleFill)
                    .symbolRenderingMode(.palette)
                    .resizableIcon(30)
                    .foregroundStyle(Color.systemGray, Color.systemGray5)
            }
        }
    }
    
    var searchbarField: some View {
        ZStack(alignment: .leading) {
            TextField("Suche...", text: $searchBar)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .padding(.leading, 32)
            #if canImport(AppKit) && os(macOS)
                .background(Color.windowBackground)
            #else
                .background(Color.systemBackground)
            #endif
                .cornerRadius(10)
                .multilineTextAlignment(.leading)
            
            Image(sfSymbol: .magnifyingglass)
                .padding(.horizontal)
                .foregroundColor(.systemGray)
        }
    }
    
    var filteredIcons: [SFSymbols] {
        if searchBar.isEmpty {
            return SFSymbols.allCases
        }
        else {
            return SFSymbols.allCases.filter { icon in
                searchBar.split(separator: " ").reduce(true) { partialResult, string in
                    let currentInclude = icon.rawValue.lowercased().contains(string.lowercased())
                    return partialResult ? partialResult && currentInclude : false
                }
            }
        }
    }
    
    func card(icon: SFSymbols) -> some View {
        Button {
            withAnimation {
                selection = icon
                showPicker = false
            }
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .fill(selection == icon ? Color.accentColor : Color.systemGray5)
                .aspectRatio(contentMode: .fit)
                .overlay {
                    Image(sfSymbol: icon)
                }
                .foregroundColor(selection == icon ? Color.white : Color.label)
        }
    }
}
