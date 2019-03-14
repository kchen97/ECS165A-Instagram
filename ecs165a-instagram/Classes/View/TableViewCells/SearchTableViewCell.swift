//
//  SearchTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableViewCell: IGBaseTableViewCell {

    private let PROFILE_PICTURE_WIDTH_HEIGHT: CGFloat = 20.0

    private let profilePicture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()

    private let usernameLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(picture: UIImage?, username: String?) {

        profilePicture.image = picture
        usernameLabel.text = username
    }

    private func setup() {

        contentView.addMultipleSubviews(views: [profilePicture, usernameLabel])

        profilePicture.snp.makeConstraints { maker in

            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(10)
            maker.height.equalTo(PROFILE_PICTURE_WIDTH_HEIGHT)
            maker.width.equalTo(PROFILE_PICTURE_WIDTH_HEIGHT)
        }

        usernameLabel.snp.makeConstraints { maker in

            maker.centerY.equalTo(profilePicture.snp.centerY)
            maker.leading.equalTo(profilePicture.snp.trailing).offset(20)
            maker.trailing.equalToSuperview().inset(20)
        }
    }
}
