//
//  ProfilePostsTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfilePostsTableViewCell: IGBaseTableViewCell {
    
    private let post1: UIButton = {
        
        let button = UIButton()
        
        if let Image = UIImage(named: "default") {
            button.setImage(Image, for: .normal)
        }
        return button
    }()
    
    private let post2: UIButton = {
        
        let button2 = UIButton()
        
        if let Image = UIImage(named: "default") {
            button2.setImage(Image, for: .normal)
        }
        return button2
    }()
    
    private let post3: UIButton = {
        
        let button3 = UIButton()
        
        if let Image = UIImage(named: "default") {
            button3.setImage(Image, for: .normal)
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
    
    func config() {
        
    }
    
    private func setup() {
        contentView.addMultipleSubviews(views: [post1, post2, post3])
        
        post1.snp.makeConstraints { maker in
            maker.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            maker.top.equalTo(contentView.snp_topMargin)
        }

        post2.snp.makeConstraints { maker in
            maker.top.equalTo(post1.snp.top)
            maker.bottom.equalTo(post1.snp.bottom)
            maker.centerX.equalTo(contentView.snp.centerX)
        }
        
        post3.snp.makeConstraints { maker in
            maker.top.equalTo(post2.snp.top)
            maker.bottom.equalTo(post2.snp.bottom)
            maker.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
        }
    }
}
