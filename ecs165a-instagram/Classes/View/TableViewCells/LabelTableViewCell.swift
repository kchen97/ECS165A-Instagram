//
//  ButtonTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/5/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit

class LabelTableViewCell: IGBaseTableViewCell {
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(title: String, color: UIColor = .clear) {
        
        label.backgroundColor = color
    }
    
    func addTarget(target: Any, selector: Selector) {
        button.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    private func setup() {
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { maker in
            
            maker.top.equalToSuperview().inset(60)
            maker.leading.equalToSuperview().inset(60)
            maker.trailing.equalToSuperview().inset(60)
            maker.bottom.equalToSuperview()
        }
    }
}
