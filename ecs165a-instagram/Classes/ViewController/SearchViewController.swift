//
//  SearchViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class SearchViewController: IGMainViewController {

    private let USERS_SECTION = 0
    private let HASHTAGS_SECTION = 1

    private let searchTableViewCellId = "searchTableViewCellId"
    private let feedTableViewCellId = "feedTableViewCellId"

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
        tableview.register(FeedTableViewCell.self, forCellReuseIdentifier: feedTableViewCellId)

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

        searchResultsObservation = searchVM.observe(\.results) { [weak self] _, _ in

            self?.reload()
        }
    }

    private func reload() {

        tableview.reloadData()
    }

    private func showCommentsScreen(postID: String?) {

        let nextScreen = CommentsViewController()
        nextScreen.commentsVM = CommentsViewModel(postID: postID)

        navigationController?.pushViewController(nextScreen, animated: true)
    }

    private func likePost(postID: String?) {

        showSpinner(message: "Liking...")

        searchVM.likePost(postID: postID) { [weak self] serviceResponse in

            self?.stopSpinner()

            if serviceResponse.isSuccess {

                self?.loadData()
            }
            else {

                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }

    private func unlikePost(postID: String?) {

        showSpinner(message: "Unliking...")

        searchVM.unlikePost(postID: postID) { [weak self] serviceResponse in

            self?.stopSpinner()

            if serviceResponse.isSuccess {

                self?.loadData()
            }
            else {

                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }

    private func loadData() {

        showSpinner(message: "Loading...")

        searchVM.search(search: searchBar.text, completion: { [weak self] response in

            self?.stopSpinner()

            if !response.isSuccess {
                self?.showMessage(body: response.errorMessage ?? "", theme: .error, style: .bottom)
            }
        })
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: - UISearchBar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

        loadData()
    }

    // MARK: - UITableView Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == USERS_SECTION ?
            searchVM.results?.users?.count ?? 0 : searchVM.results?.posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableview.dequeueReusableCell(withIdentifier: indexPath.section == USERS_SECTION ?
            searchTableViewCellId : feedTableViewCellId,
                                                 for: indexPath)

        if let cell = cell as? SearchTableViewCell {

            let user = searchVM.results?.users?[indexPath.row]

            cell.config(picture: user?.picture,
                        username: user?.username)
            cell.separatorInset = .zero
        }
        else if let cell = cell as? FeedTableViewCell {

            let post = searchVM.results?.posts?[indexPath.row]

            let tags = (post?.tags ?? []).reduce("", { $0 + " " + $1 })

            cell.config(username: post?.username,
                        image: post?.image,
                        caption: (post?.caption ?? "") + tags,
                        likes: post?.likes,
                        date: post?.date,
                        profilePicture: post?.profilePicture)

            cell.commentTapped = { [weak self] in

                self?.showCommentsScreen(postID: post?.postID)
            }

            cell.likeTapped = { [weak self] in

                if post?.liked == true {

                    self?.unlikePost(postID: post?.postID)
                }
                else {

                    self?.likePost(postID: post?.postID)
                }
            }
            cell.liked = post?.liked == true
        }
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard indexPath.section == USERS_SECTION, let username = searchVM.results?.users?[indexPath.row].username else {
            return
        }

        let profileScreen = ProfileViewController()
        profileScreen.enableSettingsAndCreatePost = false
        profileScreen.profileVM = ProfileViewModel(username: username)

        navigationController?.pushViewController(profileScreen, animated: true)
    }
}
