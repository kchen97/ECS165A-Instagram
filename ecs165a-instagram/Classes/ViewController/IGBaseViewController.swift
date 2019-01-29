//
//  IGBaseViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/22/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import Firebase

class IGBaseViewController: UIViewController {

    private let ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    internal func setup() {

        view.backgroundColor = .white
    }
}

