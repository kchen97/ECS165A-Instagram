//
//  ProfilePostsTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfilePostsTableViewCell: IGBaseTableViewCell {
    
    private var posts: [Post]?
    
    private let post1: UIButton = {
        
        let button = UIButton()
        return button
    }()
    
    private let post2: UIButton = {
        
        let button2 = UIButton()
        
        if let Image = UIImage(named: "default") {
            button2.setBackgroundImage(Image, for: .normal)
        }
        return button2
    }()
    
    private let post3: UIButton = {
        
        let button3 = UIButton()
        
        if let Image = UIImage(named: "default") {
            button3.setBackgroundImage(Image, for: .normal)
        }
        return button3
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addTarget1(target: Any, selector: Selector) {
        post1.addTarget(target, action: selector, for: .touchUpInside)
    }
    func addTarget2(target: Any, selector: Selector) {
        post2.addTarget(target, action: selector, for: .touchUpInside)
    }
    func addTarget3(target: Any, selector: Selector) {
        post3.addTarget(target, action: selector, for: .touchUpInside)
    }
    func deactivatePost2() {
        post2.removeTarget(nil, action: nil, for: .allEvents)
        post2.isHidden = true
    }
    func deactivatePost3() {
        post3.removeTarget(nil, action: nil, for: .allEvents)
        post3.isHidden = true
    }
    
    func config1(row: Int, profilePostsVM: ProfilePostsViewModel){
        print(row)
        if row <= 3 {
        if let image = profilePostsVM.posts?[(row - 1) * 3].image {
            self.post1.setBackgroundImage(image, for: .normal)
        }
        }
    }
    
    func config2(row: Int, profilePostsVM: ProfilePostsViewModel){
        if let image = profilePostsVM.posts?[((row - 1) * 3) + 1].image {
            self.post2.setBackgroundImage(image, for: .normal)
        }
    }
    
    func config3(row: Int, profilePostsVM: ProfilePostsViewModel){
        if let image = profilePostsVM.posts?[((row - 1) * 3) + 2].image {
            self.post3.setBackgroundImage(image, for: .normal)
        }
    }
    
    private func setup() {
        contentView.addMultipleSubviews(views: [post1, post2, post3])
        
        post1.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.height.equalToSuperview().inset(1)
            maker.leading.equalToSuperview()
            maker.trailing.equalTo(post2.snp.leading).inset(-1)
        }
        post2.snp.makeConstraints { maker in
            maker.top.equalTo(post1.snp.top)
            maker.bottom.equalTo(post1.snp.bottom)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(post1.snp.width).inset(2)
        }
        post3.snp.makeConstraints { maker in
            maker.top.equalTo(post2.snp.top)
            maker.bottom.equalTo(post2.snp.bottom)
            maker.leading.equalTo(post2.snp.trailing).inset(-1)
            maker.trailing.equalToSuperview()
        }
    }
}
