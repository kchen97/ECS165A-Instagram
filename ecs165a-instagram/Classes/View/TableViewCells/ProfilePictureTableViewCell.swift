//
//  ProfilePictureTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfilePictureTableViewCell: IGBaseTableViewCell {
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            button.layer.opacity = isUserInteractionEnabled ? 1.0 : 0.6
        }
    }
    
    private let button: UIButton = {
        
        let button = UIButton(type: .custom)

        button.setImage(UIImage(named:"default"), for: .normal)
        return button
    }()
    
    private let username: UILabel = {
        let username = UILabel()
        username.text = "username"
        return username
    }()
    
    private let firstName: UILabel = {
        let firstName = UILabel()
        firstName.text = "first-name"
        firstName.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 18)
        return firstName
    }()
    
    private let lastName: UILabel = {
        let lastName = UILabel()
        lastName.text = "last-name"
        lastName.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 18)
        return lastName
    }()
    
    private let followerCount: UILabel = {
        let followerCount = UILabel()
        followerCount.text = "1"
        return followerCount
    }()
    
    private let followeeCount: UILabel = {
        let followeeCount = UILabel()
        followeeCount.text = "2"
        return followeeCount
    }()
    private let followerLabel: UILabel = {
        let followeeCount = UILabel()
        followeeCount.text = "Followers"
        return followeeCount
    }()
    private let followeeLabel: UILabel = {
        let followeeCount = UILabel()
        followeeCount.text = "Following"
        return followeeCount
    }()
    private let captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.text = "Born and raised to spend my life in csif coding"
        captionLabel.numberOfLines = 3
        captionLabel.preferredMaxLayoutWidth = 160
        captionLabel.font = UIFont(name: "TimesNewRomanPSMT", size: 13)
        return captionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTarget(target: Any, selector: Selector) {
        button.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    private func setup() {
        
        contentView.addSubview(lastName)
        contentView.addSubview(username)
        contentView.addSubview(firstName)
        contentView.addSubview(button)
        contentView.addSubview(followerCount)
        contentView.addSubview(followeeCount)
        contentView.addSubview(followeeLabel)
        contentView.addSubview(followerLabel)
        contentView.addSubview(captionLabel)
        
        button.snp.makeConstraints { maker in
            
            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(10)
            maker.trailing.equalToSuperview().inset(300)
            maker.bottom.equalToSuperview().inset(20)
            button.frame = CGRect(x: 50, y: 50, width: 20, height: 80)
            button.layer.cornerRadius = 0.75 * button.bounds.size.width
            button.clipsToBounds = true
        }
        username.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(0)
        }
        firstName.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(120)
            make.top.equalToSuperview().inset(15)
        }
        lastName.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(125 + firstName.intrinsicContentSize.width)
            make.top.equalToSuperview().inset(15)
        }
        followerLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(15)
        }
        followerCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(35)
        }
        followeeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(20)
        }
        followeeCount.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(0)
        }
        captionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(120)
            make.top.equalToSuperview().inset(40)
        }
    }
}
