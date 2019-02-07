//
//  ButtonTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/5/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit

class ButtonTableViewCell: IGBaseTableViewCell {

    override var isUserInteractionEnabled: Bool {
        didSet {
            button.layer.opacity = isUserInteractionEnabled ? 1.0 : 0.6
        }
    }

    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4.0
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func config(title: String, color: UIColor,
                target: Any, selector: Selector) {

        button.addTarget(target, action: selector, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
    }

    private func setup() {

        contentView.addSubview(button)

        button.snp.makeConstraints { maker in

            maker.top.equalToSuperview().inset(60)
            maker.leading.equalToSuperview().inset(60)
            maker.trailing.equalToSuperview().inset(60)
            maker.bottom.equalToSuperview()
        }
    }
}
