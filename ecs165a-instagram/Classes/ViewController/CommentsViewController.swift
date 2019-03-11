//
//  CommentsViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CommentsViewController: IGBaseViewController {

    var commentsVM: CommentsViewModel!

    private let commentTableViewCellId = "commentTableViewCellId"
    private var commentsObservation: NSKeyValueObservation?
    private var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    private let textField: PlainTextFieldView = {

        let view = PlainTextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

        navigationItem.title = "Comments"

        tableview.delegate = self
        tableview.dataSource = self
        navigationController?.navigationBar.tintColor = .themeDarkGray

        view.addMultipleSubviews(views: [tableview, textField])

        textField.config(placeholder: "Add Comment...")

        tableview.register(CommentTableViewCell.self, forCellReuseIdentifier: commentTableViewCellId)

        tableview.snp.makeConstraints { maker in

            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalTo(textField.snp.top)
        }

        textField.snp.makeConstraints { maker in

            maker.height.equalTo(50)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
        }
        keyboardHeightLayoutConstraint = textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        keyboardHeightLayoutConstraint?.isActive = true

        textField.shouldReturn = { [weak self] comment in

            self?.postComment(comment: comment)
        }
        registerObservation()
    }

    private func postComment(comment: String?) {

        showSpinner(message: "Saving...")

        commentsVM.comment(comment: comment) { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
            else {
                self?.loadData()
            }
        }
    }

    private func loadData() {

        showSpinner(message: "Loading...")

        commentsVM.getComments { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }

    private func registerObservation() {

        commentsObservation = commentsVM.observe(\.comments) { [weak self] _, _ in

            self?.reload()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillChange(notification: Notification) {

        if let userInfo = notification.userInfo {

            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

            if endFrameY >= UIScreen.main.bounds.size.height {
                keyboardHeightLayoutConstraint?.constant = 0.0
            }
            else {
                keyboardHeightLayoutConstraint?.constant = -(endFrame?.size.height ?? 0.0)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

    private func reload() {

        tableview.reloadData()
    }

    deinit {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsVM.comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableview.dequeueReusableCell(withIdentifier: commentTableViewCellId, for: indexPath)

        if let cell = cell as? CommentTableViewCell {

            let comment = commentsVM.comments?[indexPath.row]

            cell.config(username: comment?.username,
                        image: comment?.picture,
                        date: comment?.date,
                        comment: comment?.comment)
            cell.selectionStyle = .none
        }

        return cell
    }
}
