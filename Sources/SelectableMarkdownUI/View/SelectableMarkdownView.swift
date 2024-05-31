//
//  SelectableMarkdownView.swift
//  
//
//  Created by Joao Pedro Monteiro Maia on 31/05/24.
//

import Foundation
import SwiftUI
import Down

public struct SelectableMarkdownView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var formattedText: NSAttributedString
    @State private var messageHeight: CGFloat = 0
    let text: String
    let styler: CodeStyler = CodeStyler.sharedInstance
    let down: Down
    
    public init(text: String) {
        self.text = text
        self.down = Down(markdownString: text)
        self.formattedText = (try? down.toAttributedString(styler: styler)) ?? NSAttributedString(string: text)
    }
    
    public var body: some View {
        AttributedTextView(text: formattedText) { newHeight in
            self.messageHeight = newHeight
        }
        .frame(height: messageHeight)
        .onAppear{
            self.styler.changeColorScheme(to: colorScheme)
        }
        .onChange(of: colorScheme){ new in
            styler.changeColorScheme(to: new)
            refreshContent()
        }
        .onReceive(styler.codeHighlightDidChange) { _ in
            refreshContent()
        }
    }
    
    private func refreshContent() {
        if let refreshedFormattedText = try? down.toAttributedString(styler: styler) {
            formattedText = refreshedFormattedText
        }
    }
}
