//
//  HomeTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class HomeTableViewCell: IGBaseTableViewCell {

    private let profilePicture: RoundButton = {

        let button = RoundButton()
        return button
    }()

    private let nameLabel: UILabel = {

        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Korman Chen"
        label.font = UIFont(name: label.font.fontName, size: 24)
        return label
    }()

    private let shareButton: UIButton = {

        let button = UIButton()
        return button
    }()

    // TODO: - Add Video Support
    // This is lazy var because a post can have
    // either a video or picture not both
    private lazy var picture: UIImageView = {

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
}
