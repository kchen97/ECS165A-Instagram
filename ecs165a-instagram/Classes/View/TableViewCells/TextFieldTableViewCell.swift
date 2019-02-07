//
//  TextFieldTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/5/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class TextFieldTableViewCell: IGBaseTableViewCell {

    private let textField: SkyFloatingLabelTextField = {

        let tf = SkyFloatingLabelTextField()
        tf.tintColor = .themeBlue
        tf.selectedLineColor = .themeBlue
        tf.selectedTitleColor = .themeBlue
        tf.lineHeight = 1.0
        tf.selectedLineHeight = 2.0
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func config(title: String, secureTextEntry: Bool = false) {

        textField.placeholder = title
        textField.title = title
        textField.isSecureTextEntry = secureTextEntry
    }

    private func setup() {

        contentView.addSubview(textField)

        textField.snp.makeConstraints { maker in

            maker.top.equalTo(contentView.safeAreaLayoutGuide).inset(40)
            maker.leading.equalToSuperview().inset(40)
            maker.trailing.equalToSuperview().inset(40)
            maker.bottom.equalToSuperview()
        }
    }
}
