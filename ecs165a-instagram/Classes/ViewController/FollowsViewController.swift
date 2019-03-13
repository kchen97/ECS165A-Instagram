//
//  FollowsViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/13/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

enum FollowsType {
    case followers, following
}

class FollowsViewController: IGBaseViewController {

    var type: FollowsType!
    var followsVM: FollowsViewModel!

    private let searchTableViewCellId = "searchTableViewCellId"

    private var usersObservation: NSKeyValueObservation?

    private let tableview: UITableView = {

        let view = UITableView(frame: .zero, style: .plain)
        view.tableHeaderView = UIView(frame: .zero)
        view.estimatedRowHeight = 44.0
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        showSpinner(message: "Loading...")

        if type == .followers {

            followsVM.followers { [weak self] response in

                self?.stopSpinner()

                if !response.isSuccess {
                    self?.showMessage(body: response.errorMessage ?? "", theme: .error, style: .bottom)
                }
            }
        }
        else {

            followsVM.following { [weak self] response in

                self?.stopSpinner()

                if !response.isSuccess {
                    self?.showMessage(body: response.errorMessage ?? "", theme: .error, style: .bottom)
                }
            }
        }
    }

    override func setup() {

        super.setup()

        navigationController?.navigationBar.tintColor = .themeDarkGray

        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: searchTableViewCellId)

        view.addSubview(tableview)

        tableview.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        registerObservation()
    }

    private func registerObservation() {

        usersObservation = followsVM.observe(\.users) { [weak self] _, _ in

            self?.reload()
        }
    }

    private func reload() {

        tableview.reloadData()
    }
}

extension FollowsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followsVM.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableview.dequeueReusableCell(withIdentifier: searchTableViewCellId, for: indexPath)

        if let cell = cell as? SearchTableViewCell {

            let user = followsVM.users?[indexPath.row]

            cell.config(picture: user?.picture,
                        username: user?.username)
            cell.separatorInset = .zero
        }
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let username = followsVM.users?[indexPath.row].username else {
            return
        }

        let profileScreen = ProfileViewController()
        profileScreen.enableSettingsAndCreatePost = false
        profileScreen.profileVM = ProfileViewModel(username: username)

        navigationController?.pushViewController(profileScreen, animated: true)
    }
}
