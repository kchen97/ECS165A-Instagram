//
//  FeedTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class FeedTableViewCell: IGBaseTableViewCell {

    var liked: Bool = false {

        didSet {

            likeButton.tintColor = liked ? .errorColor : .black
        }
    }

    var commentTapped: (() -> Void)?
    var likeTapped: (() -> Void)?

    private let usernameLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()

    private let profilePicture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .themeLightGray
        return view
    }()

    private let picture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private let captionLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()

    private let likesLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()

    private let dateLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 10.0)
        return label
    }()

    private let likeButton: UIButton = {

        let button = UIButton()
        button.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }()

    private let commentButton: UIButton = {

        let button = UIButton()
        button.setImage(UIImage(named: "speech-bubble"), for: .normal)
        return button
    }()

    private let viewCommentsButton: UIButton = {

        let button = UIButton()
        button.setTitle("View all comments", for: .normal)
        button.setTitleColor(.themeDarkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(username: String?,
                image: UIImage?,
                caption: String?,
                likes: Int?,
                date: String?,
                profilePicture: UIImage?) {

        usernameLabel.text = username
        picture.image = image
        likesLabel.text = "\(likes ?? 0) like(s)"
        captionLabel.setAttributedText(text: (username ?? "") + " " + (caption ?? ""),
                                       attributedTexts: [(text: username ?? "",
                                                          font: UIFont.boldSystemFont(ofSize: 12.0)
                                        )])
        dateLabel.text = "Posted on \(date ?? "")"
        self.profilePicture.image = profilePicture
    }

    private func setup() {

        contentView.addMultipleSubviews(views: [profilePicture,
                                                usernameLabel,
                                                picture,
                                                captionLabel,
                                                likesLabel,
                                                likeButton,
                                                commentButton,
                                                dateLabel,
                                                viewCommentsButton])

        profilePicture.snp.makeConstraints { maker in

            maker.top.equalToSuperview().offset(20)
            maker.leading.equalToSuperview().offset(20)
            maker.size.equalTo(CGSize(width: 30, height: 30))
        }

        usernameLabel.snp.makeConstraints { maker in

            maker.centerY.equalTo(profilePicture)
            maker.leading.equalTo(profilePicture.snp.trailing).offset(10)
            maker.trailing.equalToSuperview().inset(20)
            maker.height.equalTo(40)
        }

        picture.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.bottom).offset(10)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(300)
        }

        likeButton.snp.makeConstraints { maker in

            maker.top.equalTo(picture.snp.bottom).offset(10)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.size.equalTo(CGSize(width: 20, height: 20))
        }

        commentButton.snp.makeConstraints { maker in

            maker.top.equalTo(likeButton.snp.top)
            maker.leading.equalTo(likeButton.snp.trailing).offset(10)
            maker.size.equalTo(CGSize(width: 20, height: 20))
        }

        likesLabel.snp.makeConstraints { maker in

            maker.top.equalTo(likeButton.snp.bottom).offset(10)
            maker.leading.equalTo(likeButton.snp.leading)
            maker.trailing.equalTo(usernameLabel.snp.trailing)
            maker.height.equalTo(10)
        }

        captionLabel.snp.makeConstraints { maker in

            maker.top.equalTo(likesLabel.snp.bottom).offset(10)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.trailing.equalTo(usernameLabel.snp.trailing)
            maker.bottom.equalTo(viewCommentsButton.snp.top).offset(-6)
        }

        viewCommentsButton.snp.makeConstraints { maker in

            maker.bottom.equalTo(dateLabel.snp.top).offset(-6)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.trailing.equalTo(usernameLabel.snp.trailing)
            maker.height.equalTo(12)
        }

        dateLabel.snp.makeConstraints { maker in

            maker.bottom.equalToSuperview()
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.trailing.equalTo(usernameLabel.snp.trailing)
            maker.height.equalTo(12)
        }

        commentButton.addTarget(self, action: #selector(commentPressed), for: .touchUpInside)
        viewCommentsButton.addTarget(self, action: #selector(commentPressed), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
    }

    @objc private func commentPressed() {

        commentTapped?()
    }

    @objc private func likePressed() {

        likeTapped?()
    }
}
