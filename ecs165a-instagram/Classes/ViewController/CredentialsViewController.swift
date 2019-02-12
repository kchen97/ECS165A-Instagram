//
//  CredentialsViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CredentialsViewController: InputViewController {

    override func setup() {

        super.setup()

        configFields()

        tableview.register(TextFieldTableViewCell.self, forCellReuseIdentifier: InputType.text.rawValue)
        tableview.register(ButtonTableViewCell.self, forCellReuseIdentifier: InputType.button.rawValue)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc internal func buttonTapped() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}

extension CredentialsViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let cell = cell as? TextFieldTableViewCell {

            // TODO: - indexPath.row == 2 logic should not be in VC
            cell.config(title: viewModel.fields[indexPath.row].title,
                        secureTextEntry: indexPath.row == 1)
        }
        else if let cell = cell as? ButtonTableViewCell {

            cell.config(title: viewModel.fields[indexPath.row].title,
                        color: .themeBlue)
        }
        return cell
    }
}
