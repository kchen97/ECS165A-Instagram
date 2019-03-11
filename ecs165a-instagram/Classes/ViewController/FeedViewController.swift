//
//  FeedViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class FeedViewController: IGMainViewController {

    private let feedTableViewCellId = "feedTableViewCellId"
    private var feedObservation: NSKeyValueObservation?

    private let feedVM = FeedViewModel()

    private let refresher = UIRefreshControl()
    private let tableview: UITableView = {

        let view = UITableView(frame: .zero, style: .grouped)
        view.tableHeaderView = UIView(frame: .zero)
        view.estimatedRowHeight = 44.0
        view.backgroundColor = .white
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        loadData()
    }

    override func setup() {

        super.setup()

        tableview.delegate = self
        tableview.dataSource = self

        view.addSubview(tableview)
        tableview.addSubview(refresher)

        refresher.addTarget(self, action: #selector(pagePulled), for: .valueChanged)
        tableview.register(FeedTableViewCell.self, forCellReuseIdentifier: feedTableViewCellId)

        tableview.snp.makeConstraints { maker in

            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }

        setNavBarButtons()
        registerObservation()
    }

    private func loadData() {

        showSpinner(message: "Loading...")

        feedVM.getFeed { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }

    private func registerObservation() {

        feedObservation = feedVM.observe(\.posts) { [weak self] _, _ in

            self?.reload()
        }
    }

    private func reload() {

        tableview.reloadData()
        refresher.endRefreshing()
    }

    private func showCommentsScreen(postID: String?) {

        let nextScreen = CommentsViewController()
        nextScreen.commentsVM = CommentsViewModel(postID: postID)

        navigationController?.pushViewController(nextScreen, animated: true)
    }

    private func likePost(postID: String?) {

        showSpinner(message: "Liking...")

        feedVM.likePost(postID: postID) { [weak self] serviceResponse in

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

    @objc private func pagePulled() {
        loadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedVM.posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableview.dequeueReusableCell(withIdentifier: feedTableViewCellId, for: indexPath)

        if let cell = cell as? FeedTableViewCell {

            let post = feedVM.posts?[indexPath.row]
            let tags = (post?.tags ?? []).reduce("", { $0 + " " + $1 })

            cell.config(username: post?.username,
                        image: post?.image,
                        caption: (post?.caption ?? "") + tags,
                        likes: post?.likes,
                        date: post?.date)

            cell.commentTapped = { [weak self] in

                self?.showCommentsScreen(postID: post?.postID)
            }

            cell.likeTapped = { [weak self] in

                self?.likePost(postID: post?.postID)
            }
            cell.liked = post?.liked == true
            cell.selectionStyle = .none
        }

        return cell
    }
}
