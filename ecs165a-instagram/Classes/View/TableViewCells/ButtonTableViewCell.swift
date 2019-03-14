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

    let button: UIButton = {

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

    func config(title: String, color: UIColor = .clear) {

        button.setTitle(title, for: .normal)
        button.setTitleColor(color == .clear ? .themeBlue : .white, for: .normal)
        button.backgroundColor = color
    }

    func addTarget(target: Any, selector: Selector) {
        button.addTarget(target, action: selector, for: .touchUpInside)
    }

    private func setup() {

        contentView.addSubview(button)

        button.snp.makeConstraints { maker in

            maker.top.equalToSuperview().inset(60)
            maker.centerX.equalToSuperview()
            maker.leading.equalToSuperview().offset(30)
            maker.bottom.equalToSuperview()
        }
    }
}
