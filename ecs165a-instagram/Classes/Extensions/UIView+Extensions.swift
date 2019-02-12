//
//  UIView+Extensions.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

extension UIView {

    func addMultipleSubviews(views: [UIView]) {

        for view in views {
            self.addSubview(view)
        }
    }
}


