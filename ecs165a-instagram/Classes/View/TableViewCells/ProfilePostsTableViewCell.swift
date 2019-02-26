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
            button.setBackgroundImage(Image, for: .normal)
        }
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
    
    func config() {
        
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
