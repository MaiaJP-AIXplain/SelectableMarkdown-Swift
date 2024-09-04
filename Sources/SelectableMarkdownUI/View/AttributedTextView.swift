//
//  AttributedTextView.swift
//
//
//  Created by Joao Pedro Monteiro Maia on 31/05/24.
//

import UIKit
import SwiftUI

import UIKit
import SwiftUI

protocol StringFormatter {
    func format(string: String) -> NSAttributedString?
}

struct AttributedTextView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let text: NSAttributedString
    
    private let textView = ContentTextView()
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = UIViewController()
        
        textView.contentInset = .zero
        textView.isSelectable = true
        textView.isEditable = false
        
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.attributedText = text
        
        // Set text alignment based on the current language direction
        textView.textAlignment = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .right : .left
        
        vc.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        vc.view.isUserInteractionEnabled = true
        return vc
    }
    
    var didChangeHeight: (CGFloat) -> Void = { _ in }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let textView = uiViewController.view.subviews.first as? UITextView {
            textView.attributedText = text
            
            // Update text alignment when the view is updated
            textView.textAlignment = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .right : .left
            
            DispatchQueue.main.async {
                didChangeHeight(textView.intrinsicContentSize.height)
            }
        }
    }
    
    /// ContentTextView
    /// subclass of UITextView returning contentSize as intrinsicContentSize
    private class ContentTextView: UITextView {
        override var intrinsicContentSize: CGSize {
            let x = frame.height > 0 ? contentSize : super.intrinsicContentSize
            return super.intrinsicContentSize
        }
    }
}
