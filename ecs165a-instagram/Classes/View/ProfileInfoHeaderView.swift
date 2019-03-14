//
//  ProfileInfoHeaderView.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import Popover

class ProfileInfoHeaderView: UICollectionReusableView {

    var followersTapped: (() -> Void)?
    var followingTapped: (() -> Void)?

    var followed = false {

        didSet {

            followButton.isSelected = followed
            followButton.backgroundColor = followed ? .white : .themeBlue
        }
    }

    var saveProfileTapped: ((UIImage?, String?) -> Void)?

    var editPictureTapped: (() -> Void)? {

        didSet {

            editProfileButton.isHidden = false
        }
    }

    var followTapped: (() -> Void)? {

        didSet {

            followButton.isHidden = false
        }
    }

    let editProfileView = EditProfileView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.width,
                                                        height: 220))

    private let popover: Popover = {

        let options: [PopoverOption] = [
            .type(.down),
            .cornerRadius(20),
            .animationIn(0.6),
            .overlayBlur(.dark),
            .arrowSize(.zero)
        ]

        return Popover(options: options)
    }()

    private let profilePicture: UIImageView = {

        let view = UIImageView()
        view.image = UIImage(named: "default")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.themeBlue.cgColor
        view.layer.masksToBounds = false
        view.clipsToBounds = true

        return view
    }()

    private let nameLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let captionLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let followerCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()

    private let followingCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()

    private let postsCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followersLabel: UILabel = {

        let label = UILabel()
        label.text = "Followers"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followingLabel: UILabel = {

        let label = UILabel()
        label.text = "Following"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let postsLabel: UILabel = {

        let label = UILabel()
        label.text = "Posts"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followButton: UIButton = {

        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitle("Following", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.themeBlue, for: .selected)
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.themeBlue.cgColor
        button.isHidden = true

        return button
    }()

    private let editProfileButton: UIButton = {

        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.themeDarkGray, for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.themeDarkGray.cgColor
        button.isHidden = true

        return button
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func config(name: String?,
                caption: String?,
                posts: Int?,
                followers: Int?,
                following: Int?,
                picture: UIImage?) {

        nameLabel.text = name
        captionLabel.text = caption
        postsCountLabel.text = "\(posts ?? 0)"
        followerCountLabel.text = "\(followers ?? 0)"
        followingCountLabel.text = "\(following ?? 0)"

        if let image = picture {

            profilePicture.image = image
        }
    }

    @objc private func followPressed() {

        followTapped?()
    }

    @objc private func editProfilePressed() {

        editProfileView.config(image: profilePicture.image)

        editProfileView.pictureTapped = editPictureTapped
        editProfileView.saveTapped = { [weak self] image, text in

            self?.popover.dismiss()
            self?.saveProfileTapped?(image, text)
        }
        popover.show(editProfileView, fromView: editProfileButton)
    }

    @objc private func followersPressed() {

        followersTapped?()
    }

    @objc private func followingPressed() {

        followingTapped?()
    }

    private func setup() {

        addMultipleSubviews(views: [profilePicture,
                                    nameLabel,
                                    followerCountLabel,
                                    followingCountLabel,
                                    followingLabel,
                                    followersLabel,
                                    postsLabel,
                                    postsCountLabel,
                                    captionLabel,
                                    followButton,
                                    editProfileButton])

        profilePicture.snp.makeConstraints { maker in

            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(10)
            maker.width.equalTo(100)
            maker.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.bottom)
            maker.centerX.equalTo(profilePicture.snp.centerX)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.height.equalTo(30)
        }

        captionLabel.snp.makeConstraints { maker in

            maker.top.equalTo(nameLabel.snp.bottom)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.trailing.equalTo(snp.centerX).offset(40)
            maker.height.equalTo(30)
        }

        postsLabel.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.top)
            maker.leading.equalTo(snp.centerX).inset(-40)
            maker.width.equalTo(40)
            maker.height.equalTo(14)
        }

        postsCountLabel.snp.makeConstraints { maker in

            maker.top.equalTo(postsLabel.snp.bottom).offset(8)
            maker.leading.equalTo(postsLabel.snp.leading)
            maker.centerX.equalTo(postsLabel.snp.centerX)
            maker.height.equalTo(14)
        }

        followersLabel.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.top)
            maker.leading.equalTo(postsLabel.snp.trailing).offset(10)
            maker.width.equalTo(70)
            maker.height.equalTo(14)
        }

        followerCountLabel.snp.makeConstraints { maker in

            maker.top.equalTo(postsCountLabel.snp.top)
            maker.leading.equalTo(followersLabel.snp.leading)
            maker.centerX.equalTo(followersLabel.snp.centerX)
            maker.height.equalTo(14)
        }

        followingLabel.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.top)
            maker.leading.equalTo(followersLabel.snp.trailing).offset(10)
            maker.width.equalTo(70)
            maker.height.equalTo(14)
        }

        followingCountLabel.snp.makeConstraints { maker in

            maker.top.equalTo(postsCountLabel.snp.top)
            maker.leading.equalTo(followingLabel.snp.leading)
            maker.centerX.equalTo(followingLabel.snp.centerX)
            maker.height.equalTo(14)
        }

        followButton.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.centerY)
            maker.leading.equalTo(postsLabel.snp.leading)
            maker.trailing.equalTo(followingLabel.snp.trailing)
            maker.height.equalTo(40)
        }

        editProfileButton.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.centerY)
            maker.leading.equalTo(postsLabel.snp.leading)
            maker.trailing.equalTo(followingLabel.snp.trailing)
            maker.height.equalTo(40)
        }

        followButton.addTarget(self, action: #selector(followPressed), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)

        let followersTap = UITapGestureRecognizer(target: self, action: #selector(followersPressed))
        let followingTap = UITapGestureRecognizer(target: self, action: #selector(followingPressed))

        followerCountLabel.addGestureRecognizer(followersTap)
        followingCountLabel.addGestureRecognizer(followingTap)
    }
}
