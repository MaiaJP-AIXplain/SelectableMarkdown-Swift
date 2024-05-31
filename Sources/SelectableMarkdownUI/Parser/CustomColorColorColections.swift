//
//  File.swift
//  
//
//  Created by Joao Pedro Monteiro Maia on 31/05/24.
//

import Foundation
import UIKit
import Down
public typealias DownColor = UIColor
public struct CustomColorCollection: ColorCollection {

    // MARK: - Properties

    public var heading1: DownColor
    public var heading2: DownColor
    public var heading3: DownColor
    public var heading4: DownColor
    public var heading5: DownColor
    public var heading6: DownColor
    public var body: DownColor
    public var code: DownColor
    public var link: DownColor
    public var quote: DownColor
    public var quoteStripe: DownColor
    public var thematicBreak: DownColor
    public var listItemPrefix: DownColor
    public var codeBlockBackground: DownColor

    // MARK: - Life cycle

    public init(
        heading1: DownColor = .label,
        heading2: DownColor = .label,
        heading3: DownColor = .label,
        heading4: DownColor = .label,
        heading5: DownColor = .label,
        heading6: DownColor = .label,
        body: DownColor = .label,
        code: DownColor = .label,
        link: DownColor = .link,
        quote: DownColor = .systemPurple,
        quoteStripe: DownColor = .label,
        thematicBreak: DownColor = .systemGray4,
        listItemPrefix: DownColor = .secondaryLabel,
        codeBlockBackground: DownColor = .init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
    ) {
        self.heading1 = heading1
        self.heading2 = heading2
        self.heading3 = heading3
        self.heading4 = heading4
        self.heading5 = heading5
        self.heading6 = heading6
        self.body = body
        self.code = code
        self.link = link
        self.quote = quote
        self.quoteStripe = quoteStripe
        self.thematicBreak = thematicBreak
        self.listItemPrefix = listItemPrefix
        self.codeBlockBackground = codeBlockBackground
    }

}
