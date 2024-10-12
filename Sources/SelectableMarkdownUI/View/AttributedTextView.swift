//
//  AttributedTextView.swift
//
//
//  Created by Joao Pedro Monteiro Maia on 31/05/24.
//

import UIKit
import SwiftUI

protocol StringFormatter {
    func format(string: String) -> NSAttributedString?
}

@MainActor
struct AttributedTextView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let text: NSAttributedString
    
    private let textView = ContentTextView()

    init(text: NSAttributedString, editMenuActions: [ EditMenuAction ]? = nil, didChangeHeight: @escaping (CGFloat) -> Void) {
        self.text = text
        textView.editMenuActions = editMenuActions ?? []
        self.didChangeHeight = didChangeHeight
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = UIViewController()
        
        textView.contentInset = .zero
        textView.isSelectable = true
        textView.isEditable = false

        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.attributedText = text
        vc.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor),
            textView.rightAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.rightAnchor),
            
        ])
        vc.view.isUserInteractionEnabled = true
        return vc
    }
    
    var didChangeHeight: (CGFloat) -> Void = { _ in }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let textView = uiViewController.view.subviews.first as? UITextView {
            textView.attributedText = text
            DispatchQueue.main.async {
                didChangeHeight(textView.intrinsicContentSize.height)
            }
        }
    }
    
    /// ContentTextView
    /// subclass of UITextView returning contentSize as intrinsicContentSize
    private class ContentTextView: UITextView {
        var editMenuActions = [ EditMenuAction ]()
        
        override var intrinsicContentSize: CGSize {
            let x = frame.height > 0 ? contentSize : super.intrinsicContentSize
            return super.intrinsicContentSize
        }

        override func editMenu(for textRange: UITextRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
            var actions = suggestedActions

            editMenuActions.reversed().forEach { actionTemplate in
                let action = UIAction(title: actionTemplate.label) { (action) in
                    if let range = self.selectedTextRange,
                       let selectedText = self.text(in: range) {
                        actionTemplate.action(selectedText)
                    }
                }

                actions.insert(action, at: 0)
            }

            return UIMenu(children: actions)
        }
    }
}

public struct EditMenuAction {
    var label: String
    var action: (String) -> Void

    public init(label: String, action: @escaping (String) -> Void) {
        self.label = label
        self.action = action
    }
}
