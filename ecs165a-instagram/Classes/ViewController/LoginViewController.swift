//
//  LoginViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class LoginViewController: CredentialsViewController {

    private let EMAIL_ROW = 0
    private let PASSWORD_ROW = 1
    private let LOGIN_BUTTON_ROW = 2

    override func configFields() {
        viewModel.fields = [
            ("E-mail", .generic),
            ("Password", .password),
            ("Login", .button),
            ("Don't have an account? Sign Up.", .button)
        ]
    }

    override func buttonTapped() {

        super.buttonTapped()

        showSpinner()

        userInfoVM.login { [weak self] serviceResponse in

            self?.stopSpinner()

            if serviceResponse.isSuccess {
                self?.navigationController?.pushViewController(ProfileViewController(), animated: true)
            }
        }
    }

    @objc private func signUpTapped() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
}

extension LoginViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableview, cellForRowAt: indexPath)

        if let cell = cell as? TextFieldTableViewCell {

            cell.textDidChange = { [weak self] text in

                switch indexPath.row {

                case self?.EMAIL_ROW:
                    self?.userInfoVM.set(email: text)

                case self?.PASSWORD_ROW:
                    self?.userInfoVM.set(password: text)

                default:
                    fatalError("Index out of range")

                }

                self?.mainActionButtonCell.isUserInteractionEnabled = self?.userInfoVM.loginEnabled() ?? false
            }
        }
        else if let cell = cell as? ButtonTableViewCell {

            if indexPath.row == LOGIN_BUTTON_ROW {

                mainActionButtonCell = cell
                mainActionButtonCell.isUserInteractionEnabled = userInfoVM.loginEnabled()
            }

            cell.config(title: viewModel.fields[indexPath.row].title,
                        color: indexPath.row == LOGIN_BUTTON_ROW ? .themeBlue : .clear)
            cell.addTarget(target: self,
                           selector: indexPath.row == LOGIN_BUTTON_ROW
                            ? #selector(buttonTapped) : #selector(signUpTapped))
        }
        return cell
    }
}
