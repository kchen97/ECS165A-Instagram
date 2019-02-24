//
//  CreateAccountViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CreateAccountViewController: CredentialsViewController {

    private let FIRST_NAME_ROW = 0
    private let LAST_NAME_ROW = 1
    private let USERNAME_ROW = 2
    private let EMAIL_ROW = 3
    private let PASSWORD_ROW = 4
    private let CONFIRM_PASSWORD_ROW = 5

    override func configFields() {

        viewModel.fields = [
            ("First Name", .generic),
            ("Last Name", .generic),
            ("Username", .generic),
            ("E-mail", .generic),
            ("Password", .password),
            ("Confirm Password", .password),
            ("Create", .button)
        ]
    }

    override func buttonTapped() {

        super.buttonTapped()

        showSpinner()

        userInfoVM.signUp { [weak self] serviceResponse in

            self?.stopSpinner()

            if serviceResponse.isSuccess {
                self?.present(IGMainTabBarController(), animated: true, completion: nil)
            }
        }
    }
}

extension CreateAccountViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let cell = cell as? TextFieldTableViewCell {

            cell.validate = { [weak self] text in

                switch indexPath.row {

                case self?.USERNAME_ROW:
                    return self?.userInfoVM.validate(username: text) ?? false

                case self?.EMAIL_ROW:
                    return self?.userInfoVM.validate(email: text) ?? false

                case self?.PASSWORD_ROW:
                    return self?.userInfoVM.validate(password: text) ?? false

                default:
                    return true
                }
            }

            cell.textDidChange = { [weak self] text in

                switch indexPath.row {

                case self?.FIRST_NAME_ROW:
                    self?.userInfoVM.set(firstName: text)

                case self?.LAST_NAME_ROW:
                    self?.userInfoVM.set(lastName: text)

                case self?.USERNAME_ROW:
                    self?.userInfoVM.set(username: text)

                case self?.EMAIL_ROW:
                    self?.userInfoVM.set(email: text)

                case self?.PASSWORD_ROW:
                    self?.userInfoVM.set(password: text)

                case self?.CONFIRM_PASSWORD_ROW:
                    self?.userInfoVM.set(confirmPassword: text)

                default:
                    fatalError("Index out of range")
                }

                self?.mainActionButtonCell.isUserInteractionEnabled = self?.userInfoVM.signUpEnabled() ?? false
            }
        }
        else if let cell = cell as? ButtonTableViewCell {

            mainActionButtonCell = cell
            mainActionButtonCell.isUserInteractionEnabled = userInfoVM.signUpEnabled()

            cell.addTarget(target: self, selector: #selector(buttonTapped))
        }
        return cell
    }
}
