//
//  SearchViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class SearchViewController: IGMainViewController {

    private let searchTableViewCellId = "searchTableViewCellId"

    private var searchResultsObservation: NSKeyValueObservation?
    private let searchVM = SearchViewModel()

    private let searchBar: UISearchBar = {

        let view = UISearchBar()
        let textfield = view.value(forKey: "searchField") as? UITextField

        view.barTintColor = .white
        view.placeholder = "Search"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        textfield?.backgroundColor = .themeLightGray
        return view
    }()

    private let tableview: UITableView = {

        let view = UITableView(frame: .zero, style: .plain)
        view.tableHeaderView = UIView(frame: .zero)
        view.estimatedRowHeight = 44.0
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

    override func setup() {

        super.setup()

        searchBar.delegate = self

        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: searchTableViewCellId)

        view.addMultipleSubviews(views: [tableview, searchBar])

        searchBar.snp.makeConstraints { maker in

            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(60)
        }

        tableview.snp.makeConstraints { maker in

            maker.top.equalTo(searchBar.snp.bottom)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }

        registerObservation()
        setNavBarButtons()
    }

    private func registerObservation() {

        searchResultsObservation = searchVM.observe(\.users) { [weak self] _, _ in

            self?.reload()
        }
    }

    private func reload() {

        tableview.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: - UISearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

        searchVM.search(username: searchBar.text, completion: { [weak self] response in

            if !response.isSuccess {
                self?.showMessage(body: response.errorMessage ?? "", theme: .error, style: .bottom)
            }
        })
    }

    // MARK: - UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableview.dequeueReusableCell(withIdentifier: searchTableViewCellId, for: indexPath)

        if let cell = cell as? SearchTableViewCell {

            cell.config(picture: searchVM.users?[indexPath.row].picture,
                        username: searchVM.users?[indexPath.row].username)
            cell.separatorInset = .zero
            cell.selectionStyle = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let username = searchVM.users?[indexPath.row].username else {
            return
        }

        let profileScreen = ProfileViewController()
        profileScreen.enableSettingsAndCreatePost = false
        profileScreen.profileVM = ProfileViewModel(username: username)

        navigationController?.pushViewController(profileScreen, animated: true)
    }
}
