//
//  ProfileInfoTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: IGBaseTableViewCell {
    
    private let profilePicture: UIButton = {
        
        let button = UIButton()
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        if let Image = UIImage(named: "default") {
            button.setImage(Image, for: .normal)
        }
        button.layer.cornerRadius = 45
        button.layer.masksToBounds = true
        return button
    }()
    
    private let nameLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let captionLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let followerCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let followingCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let postsCountLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followersLabel: UILabel = {

        let label = UILabel()
        label.text = "Followers"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followingLabel: UILabel = {

        let label = UILabel()
        label.text = "Following"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let postsLabel: UILabel = {

        let label = UILabel()
        label.text = "Posts"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func config(name: String?,
                caption: String?,
                posts: Int?,
                followers: Int?,
                following: Int?) {

        nameLabel.text = name
        captionLabel.text = caption
        postsCountLabel.text = "\(posts ?? 0)"
        followerCountLabel.text = "\(followers ?? 0)"
        followingCountLabel.text = "\(following ?? 0)"
    }
    
    func frameData() -> CGFloat {
        return followingLabel.frame.origin.x
    }
    
    private func setup() {

        contentView.addMultipleSubviews(views: [profilePicture,
                                                nameLabel,
                                                followerCountLabel,
                                                followingCountLabel,
                                                followingLabel,
                                                followersLabel,
                                                postsLabel,
                                                postsCountLabel,
                                                captionLabel])
        
        profilePicture.snp.makeConstraints { maker in

            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(10)
            maker.width.equalTo(90)
            maker.height.equalTo(90)
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
            maker.trailing.equalTo(contentView.snp.centerX)
            maker.height.equalTo(30)
        }
        
        followingLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalToSuperview().inset(10)
            maker.width.equalTo(64)
            maker.height.equalTo(14)
        }
        
        followingCountLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(followingLabel.snp.bottom).offset(8)
            maker.leading.equalTo(followingLabel.snp.leading)
            maker.centerX.equalTo(followingLabel.snp.centerX)
            maker.height.equalTo(14)
        }
        
        followersLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalTo(followingLabel.snp.leading).inset(-10)
            maker.width.equalTo(60)
            maker.height.equalTo(14)
        }
        
        followerCountLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(followingCountLabel.snp.top)
            maker.leading.equalTo(followersLabel.snp.leading)
            maker.centerX.equalTo(followersLabel.snp.centerX)
            maker.height.equalTo(14)
        }
        
        postsLabel.snp.makeConstraints { maker in

            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalTo(followersLabel.snp.leading).inset(-10)
            maker.width.equalTo(40)
            maker.height.equalTo(14)
        }

        postsCountLabel.snp.makeConstraints { maker in

            maker.top.equalTo(followingCountLabel.snp.top)
            maker.leading.equalTo(postsLabel.snp.leading)
            maker.centerX.equalTo(postsLabel.snp.centerX)
            maker.height.equalTo(14)
        }
    }
}
