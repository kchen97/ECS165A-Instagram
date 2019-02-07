//
//  LoginViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class LoginViewController: CredentialsViewController {

    override func configFields() {
        viewModel.fields = [
            ("Username", .text),
            ("Password", .text),
            ("Login", .button)
        ]
    }
}
