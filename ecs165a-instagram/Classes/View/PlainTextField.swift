//
//  PlainTextField.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class PlainTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
