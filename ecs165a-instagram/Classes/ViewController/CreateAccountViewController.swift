//
//  CreateAccountViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CreateAccountViewController: CredentialsViewController {

    private let createAcountVM = CreateAccountViewModel()

    override func configFields() {
        viewModel.fields = [
            ("E-mail", .text),
            ("Password", .text),
            ("Create", .button)
        ]
    }
}

extension CreateAccountViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let cell = cell as? TextFieldTableViewCell {

            cell.validate = { [weak self] text in
                return (indexPath.row == 0
                    ? self?.createAcountVM.validate(email: text)
                    : self?.createAcountVM.validate(password: text)) ?? false
            }
        }
        else if let cell = cell as? ButtonTableViewCell {
            cell.addTarget(target: self, selector: #selector(buttonTapped))
        }
        return cell
    }
}
