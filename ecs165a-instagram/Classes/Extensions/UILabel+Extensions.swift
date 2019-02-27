//
//  UILabel+Extensions.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

typealias AttributedText = (text: String, font: UIFont)

extension UILabel {

    func setAttributedText(text: String?, attributedTexts: [AttributedText] = []) {

        let mutableString = NSMutableAttributedString(string: text ?? "")

        for attrText in attributedTexts {

            let range = ((text ?? "") as NSString).range(of: attrText.text)
            mutableString.addAttributes([NSAttributedString.Key.font: attrText.font], range: range)
        }
        self.attributedText = mutableString
    }
}
