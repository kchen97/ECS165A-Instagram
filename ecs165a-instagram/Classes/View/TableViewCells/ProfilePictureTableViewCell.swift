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

        button.setImage(UIImage(named:"Image"), for: .normal) //Set image here
        return button
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
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { maker in
            
            maker.top.equalToSuperview().inset(10)
            maker.leading.equalToSuperview().inset(10)
            maker.trailing.equalToSuperview().inset(300)
            maker.bottom.equalToSuperview().inset(20)
            button.frame = CGRect(x: 50, y: 50, width: 20, height: 80)
            button.layer.cornerRadius = 0.75 * button.bounds.size.width
            button.clipsToBounds = true
        }
    }
}
