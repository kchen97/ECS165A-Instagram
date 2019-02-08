//
//  InputViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class InputViewController: IGBaseViewController {

    let textFieldCellId = "textFieldCellId"
    let buttonFieldCellId = "buttonFieldCellId"

    let viewModel = InputViewModel()
    let tableview = UITableView()

    private let ROW_HEIGHT: CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setup() {
        super.setup()

        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.showsVerticalScrollIndicator = false

        view.addSubview(tableview)

        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    internal func configFields() {}
}

extension InputViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.fields[indexPath.row].type.rawValue, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
