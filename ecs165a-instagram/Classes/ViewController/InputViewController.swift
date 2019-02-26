//
//  InputViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class InputViewController: IGBaseViewController {

    lazy var textFieldCellId = "textFieldCellId"
    lazy var plainTextViewCellId = "plainTextViewCellId"
    lazy var buttonFieldCellId = "buttonFieldCellId"
    lazy var imageFieldCellId = "imageFieldCellId"

    let viewModel = InputViewModel()
    let tableview = UITableView(frame: .zero, style: .grouped)

    override func setup() {

        super.setup()

        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.showsVerticalScrollIndicator = false
        tableview.estimatedRowHeight = 10.0
        tableview.rowHeight = UITableView.automaticDimension
        tableview.backgroundColor = .white

        view.addSubview(tableview)

        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // Must override
    internal func getCellIdForRow(row: Int) -> String {
        return ""
    }

    internal func configFields() {}
}

extension InputViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdForRow(row: indexPath.row),
                                                 for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
