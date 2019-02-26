//
//  UIAlertController+Extensions.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

extension UIAlertController {

    func addAction(actions: [UIAlertAction]) {

        for action in actions {
            addAction(action)
        }
    }
}
