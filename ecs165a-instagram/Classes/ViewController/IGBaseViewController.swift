//
//  IGBaseViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/22/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftMessages

class IGBaseViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        setup()
    }

    internal func setup() {

        view.backgroundColor = .white
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func stopSpinner() {
        SVProgressHUD.dismiss()
    }

    func showMessage(title: String = "",
                     body: String,
                     theme: IGMessageTheme,
                     style: SwiftMessages.PresentationStyle) {

        let view = MessageView.viewFromNib(layout: .cardView)
        var config = SwiftMessages.Config()

        view.config(title: title, body: body, theme: theme)
        config.presentationStyle = style
        config.duration = .forever

        SwiftMessages.show(config: config, view: view)
    }
}

