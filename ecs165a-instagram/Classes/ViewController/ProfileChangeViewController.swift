//
//  ProfileChangeViewController.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileChangeViewController: ProfilePageViewController {
    
    override func setup() {
        
        super.setup()
        
        configFields()
        
        tableview.register(ProfilePictureTableViewCell.self, forCellReuseIdentifier: profileFieldCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc internal func buttonTapped() {
        print("Profile Picture Tapped")
    }
}

extension ProfileChangeViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if cell is ProfilePictureTableViewCell {}
        return cell
    }
}

