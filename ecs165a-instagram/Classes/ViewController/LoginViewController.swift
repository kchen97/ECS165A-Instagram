//
//  LoginViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class LoginViewController: CredentialsViewController {

    override func configFields() {
        viewModel.fields = [
            ("E-mail", .text),
            ("Password", .text),
            ("Login", .button),
            ("Don't have an account? Sign Up.", .button)
        ]
    }

    @objc private func signUpTapped() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
}

extension LoginViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableview, cellForRowAt: indexPath)

        if let cell = cell as? ButtonTableViewCell {

            cell.config(title: viewModel.fields[indexPath.row].title,
                        color: indexPath.row == 2 ? .themeBlue : .clear)
            cell.addTarget(target: self,
                           selector: indexPath.row == 2
                            ? #selector(buttonTapped) : #selector(signUpTapped))
        }
        return cell
    }
}
