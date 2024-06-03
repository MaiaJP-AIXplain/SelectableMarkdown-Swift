import SwiftUI
import Down
import HighlightSwift
import Combine
import UIKit

public final class CodeStyler:DownStyler{
    

    public static var sharedInstance:CodeStyler = CodeStyler()
    
    static var codeHighlight:[Int:AttributedString] = [:]

    @MainActor
    static var highlight = HighlightSwift.Highlight()
    
    
    var colorScheme:ColorScheme = .light
    var highlightTheme:HighlightTheme = .xcode
    
    let codeHighlightDidChange = PassthroughSubject<Void,Never>()
    
    private init(){
        super.init(configuration: DownStylerConfiguration(colors:CustomColorCollection()))
    }
    
    public func changeColorScheme(to colorScheme:ColorScheme){
        self.colorScheme = colorScheme
        Self.codeHighlight = [:]
        codeHighlightDidChange.send()
    }
    
    public func changeTheme(to theme: HighlightTheme){
        self.highlightTheme = theme
        Self.codeHighlight = [:]
        codeHighlightDidChange.send()
    }
    



    public override func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {
        if let result = Self.codeHighlight[str.hashValue]{
            str.setAttributedString(NSAttributedString(result))
        }else{
            Task{ @MainActor in
                
                var colors = HighlightColors.light(highlightTheme)
                if colorScheme == .dark {
                    colors = HighlightColors.dark(highlightTheme)
                }
                
                var result: HighlightResult = try await Self.highlight.request(str.string,colors: colors)

                let updatedAttributedText = NSMutableAttributedString(result.attributedText)
                 import SwiftUI
import Down
import HighlightSwift
import Combine
import UIKit

public final class CodeStyler:DownStyler{
    

    public static var sharedInstance:CodeStyler = CodeStyler()
    
    static var codeHighlight:[Int:AttributedString] = [:]

    @MainActor
    static var highlight = HighlightSwift.Highlight()
    
    
    var colorScheme:ColorScheme = .light
    var highlightTheme:HighlightTheme = .xcode
    
    let codeHighlightDidChange = PassthroughSubject<Void,Never>()
    
    private init(){
        super.init(configuration: DownStylerConfiguration(colors:CustomColorCollection()))
    }
    
    public func changeColorScheme(to colorScheme:ColorScheme){
        self.colorScheme = colorScheme
        Self.codeHighlight = [:]
        codeHighlightDidChange.send()
    }
    
    public func changeTheme(to theme: HighlightTheme){
        self.highlightTheme = theme
        Self.codeHighlight = [:]
        codeHighlightDidChange.send()
    }
    



    public override func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {
        if let result = Self.codeHighlight[str.hashValue]{
            str.setAttributedString(NSAttributedString(result))
        }else{
            Task{ @MainActor in
                
                var colors = HighlightColors.light(highlightTheme)
                if colorScheme == .dark {
                    colors = HighlightColors.dark(highlightTheme)
                }
                
                var result: HighlightResult = try await Self.highlight.request(str.string,colors: colors)

                let updatedAttributedText = NSMutableAttributedString(result.attributedText)
                updatedAttributedText.mutableString.replaceOccurrences(of: "\u{2028}", with: "\n", options: NSString.CompareOptions.caseInsensitive, range: NSRange(location: 0, length: updatedAttributedText.length))
                updatedAttributedText.append(NSAttributedString(string: "\n"))
                updatedAttributedText.addAttribute(.font, value: UIFont.monospacedSystemFont(ofSize: 15, weight: .regular), range: NSRange(location: 0, length: updatedAttributedText.length))

                //TODO: Rounded BG

                Self.codeHighlight[str.hashValue] = AttributedString(updatedAttributedText)

                codeHighlightDidChange.send()
            }
        }
    }
    
    
//    @objc private func handleColorSchemeChange() {
//            if UITraitCollection.current.userInterfaceStyle == .dark {
//                self.colorScheme = .dark
//            } else {
//                self.colorScheme = .light
//            }
//        }
//    
    //TODO: Code smal blocks
}

                updatedAttributedText.append(NSAttributedString(string: "\n"))
                updatedAttributedText.addAttribute(.font, value: UIFont.monospacedSystemFont(ofSize: 15, weight: .regular), range: NSRange(location: 0, length: updatedAttributedText.length))

                //TODO: Rounded BG

                Self.codeHighlight[str.hashValue] = AttributedString(updatedAttributedText)

                codeHighlightDidChange.send()
            }
        }
    }
    
    
//    @objc private func handleColorSchemeChange() {
//            if UITraitCollection.current.userInterfaceStyle == .dark {
//                self.colorScheme = .dark
//            } else {
//                self.colorScheme = .light
//            }
//        }
//    
    //TODO: Code smal blocks
}
