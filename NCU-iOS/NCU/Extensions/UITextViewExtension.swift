//
//  UITextViewExtension.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

extension UITextView {
    func style(with textStyle: UIFont.TextStyle = .body, color: UIColor? = nil, alignment: NSTextAlignment = .left) {
        font = UIFont.preferredFont(forTextStyle: textStyle)
        if let color = color {
            textColor = color
        }
        textAlignment = alignment
    }
}
