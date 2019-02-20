//
//  ProfileViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileViewController: IGBaseViewController {

    let profileVM = ProfileViewModel()

    private let profileInfoCellId = "profileInfoCellId"

    private let tableview = UITableView()
    
    private let ROW_HEIGHT: CGFloat = 200

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        profileVM.getProfile { [weak self] serviceResponse in

            self?.navigationItem.title = self?.profileVM.profile?.username

            if serviceResponse.isSuccess {
                self?.tableview.reloadData()
            }
        }
    }
    
    override func setup() {
        
        super.setup()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.showsVerticalScrollIndicator = false

        tableview.register(ProfileInfoTableViewCell.self, forCellReuseIdentifier: profileInfoCellId)
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }

        setNavBarButtons()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: profileInfoCellId, for: indexPath)
        cell.selectionStyle = .none

        if let cell = cell as? ProfileInfoTableViewCell {

            cell.config(name: profileVM.profile?.fullName,
                        caption: profileVM.profile?.biography,
                        posts: profileVM.profile?.posts,
                        followers: profileVM.profile?.followers,
                        following: profileVM.profile?.following)
        }

        return cell
    }
}
