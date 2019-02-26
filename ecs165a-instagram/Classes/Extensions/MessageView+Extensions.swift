//
//  MessageView+Extensions.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/25/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import SwiftMessages

enum IGMessageTheme {

    case info, error, warning, success
}

extension MessageView {

    func config(title: String = "",
                body: String,
                theme: IGMessageTheme) {

        var color: UIColor!

        switch theme {

        case .info:
            color = .infoColor

        case .success:
            color = .successColor

        case .warning:
            color = .warningColor

        case .error:
            color = .errorColor
        }

        configureTheme(backgroundColor: color,
                       foregroundColor: theme == .info
                        ? .darkText : .white)
        configureContent(title: title, body: body)

        iconImageView?.isHidden = true
        button?.isHidden = true
    }
}
