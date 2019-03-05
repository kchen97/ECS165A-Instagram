//
//  ProfileInfoTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//
import UIKit

class ProfileInfoTableViewCell: IGBaseTableViewCell {
    
    let profilePicture: UIButton = {
        
        let button = UIButton()
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        return button
    }()
    
    let followingButton: UIButton = {
        
        let button = UIButton()
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.themeBlue.cgColor
        button.setTitleColor(.themeBlue, for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let captionLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let followerCountLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let followingCountLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let postsCountLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let followersLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Followers"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let followingLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Following"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let postsLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Posts"
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
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
                following: Int?,
                profileImage: UIImage?) {
        
        nameLabel.text = name
        captionLabel.text = caption
        postsCountLabel.text = "\(posts ?? 0)"
        followerCountLabel.text = "\(followers ?? 0)"
        followingCountLabel.text = "\(following ?? 0)"
        
        if let image = profileImage {
            profilePicture.setBackgroundImage(image, for: .normal)
        } else if let image = UIImage(named: "default") {
            profilePicture.setBackgroundImage(image, for: .normal)
        }
    }
    
    func addTarget(target: Any, selector: Selector) {
        profilePicture.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func activateFollowButton(target: Any?, selector: Selector) {
        followingButton.addTarget(target, action: selector, for: .touchUpInside)
        followingButton.isHidden = false
    }
    
    func deactivateFollowButton() {
        followingButton.removeTarget(nil, action: nil, for: .allEvents)
        followingButton.isHidden = true
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
                                                captionLabel,
                                                followingButton])
        
        profilePicture.snp.makeConstraints { maker in
            
            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(10)
            maker.width.equalToSuperview().multipliedBy(0.3)
            maker.height.equalTo(profilePicture.snp.width)
        }
        
        nameLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.bottom).offset(3)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.height.equalTo(30)
            maker.trailing.equalTo(contentView.snp.centerX)
        }
        
        captionLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(nameLabel.snp.bottom)
            maker.leading.equalTo(profilePicture.snp.leading)
            maker.trailing.equalToSuperview().inset(10)
            maker.bottom.equalToSuperview()
        }// Will need to set a max caption size of 3 lines
        
        followingLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalToSuperview().inset(10)
            maker.leading.equalTo(followersLabel.snp.trailing).inset(-10)
        }
        
        followingCountLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(followingLabel.snp.bottom).offset(5)
            maker.centerX.equalTo(followingLabel.snp.centerX)
            maker.width.equalTo(followingLabel.snp.width).multipliedBy(0.14)
        }
        
        followersLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalTo(followingLabel.snp.leading).inset(-10)
            maker.leading.equalTo(postsLabel.snp.trailing).inset(-15)
            maker.width.equalTo(followingLabel.snp.width).multipliedBy(1.05)
        }
        
        followerCountLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(followingCountLabel.snp.top)
            maker.centerX.equalTo(followersLabel.snp.centerX)
            maker.width.equalTo(followingLabel.snp.width).multipliedBy(0.14)
        }
        
        postsLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(profilePicture.snp.top)
            maker.trailing.equalTo(followersLabel.snp.leading).inset(-15)
            maker.trailing.equalTo(contentView.snp.centerX)
            maker.width.equalTo(followersLabel.snp.width).multipliedBy(0.55)
        }
        
        postsCountLabel.snp.makeConstraints { maker in
            
            maker.top.equalTo(followingCountLabel.snp.top)
            maker.centerX.equalTo(postsLabel.snp.centerX)
            maker.width.equalTo(followingLabel.snp.width).multipliedBy(0.14)
        }
        
        followingButton.snp.makeConstraints { maker in
            
            maker.leading.equalTo(postsLabel.snp.leading)
            maker.trailing.equalTo(followingLabel.snp.trailing)
            maker.top.equalTo(followerCountLabel.snp.bottom).offset(20)
            maker.bottom.equalTo(nameLabel.snp.bottom)
        }
    }
}
