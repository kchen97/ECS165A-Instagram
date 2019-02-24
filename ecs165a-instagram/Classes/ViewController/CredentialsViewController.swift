//
//  CredentialsViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CredentialsViewController: InputViewController {

    internal var mainActionButtonCell: ButtonTableViewCell!

    internal let userInfoVM = UserInfoViewModel()

    private let ROW_HEIGHT: CGFloat = 100

    override func setup() {

        super.setup()

        configFields()

        tableview.register(TextFieldTableViewCell.self, forCellReuseIdentifier: textFieldCellId)
        tableview.register(ButtonTableViewCell.self, forCellReuseIdentifier: buttonFieldCellId)
    }

    override func getCellIdForRow(row: Int) -> String {

        return viewModel.fields[row].type == .button
            ? buttonFieldCellId : textFieldCellId
    }

    @objc internal func buttonTapped() {}
}

extension CredentialsViewController {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let cell = cell as? TextFieldTableViewCell {

            // TODO: - indexPath.row == 2 logic should not be in VC
            cell.config(title: viewModel.fields[indexPath.row].title,
                        secureTextEntry: viewModel.fields[indexPath.row].type == .password)
        }
        else if let cell = cell as? ButtonTableViewCell {

            cell.config(title: viewModel.fields[indexPath.row].title,
                        color: .themeBlue)
        }
        return cell
    }
}
