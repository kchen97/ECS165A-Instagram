//
//  ProfileViewController.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileViewController: ProfileChangeViewController {
    
    override func configFields() {
        viewModel.fields = [
            ("E-mail", .button),
        ]
    }
}

extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cell = cell as? ProfilePictureTableViewCell {
            cell.addTarget(target: self, selector: #selector(buttonTapped))
        }
        return cell
    }
}
