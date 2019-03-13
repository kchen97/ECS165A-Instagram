//
//  ProfileViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileViewController: IGMainViewController {
    
    private var profileImage: UIImage?
    private var profileInfoTableViewCell: ProfileInfoTableViewCell?
    var enableSettingsAndCreatePost: Bool = true
    var profileVM = ProfileViewModel()
    var profilePostsVM = ProfilePostsViewModel()
    
    let profileInfoCellId = "profileInfoCellId"
    let profilePostsTableViewCellId = "profilePostsTableViewCellId"

    private let tableview = UITableView()
    
    private let ROW_HEIGHT: CGFloat = 200

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        showSpinner(message: "Loading...")
        
        profileVM.getProfile() { [weak self] serviceResponse in
            
            
            self?.navigationItem.title = self?.profileVM.profile?.username

            if serviceResponse.isSuccess {
                self?.profilePostsVM.getUserPosts(username: self?.profileVM.profile?.username) { [weak self] serviceResponse in
                    
                    self?.stopSpinner()
                    self?.navigationItem.title = self?.profileVM.profile?.username
                    
                    if serviceResponse.isSuccess {
                        self?.tableview.reloadData()
                    }
                    else {
                        self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                          theme: .error,
                                          style: .bottom)
                    }
                }
                self?.tableview.reloadData()
            }
            else {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
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
        tableview.register(ProfilePostsTableViewCell.self, forCellReuseIdentifier: profilePostsTableViewCellId)
        
        view.addSubview(tableview)
        
        tableview.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }

        if enableSettingsAndCreatePost {
            setNavBarButtons()
        }
        else {
            navigationController?.navigationBar.tintColor = .themeDarkGray
        }
    }
    
    @objc func profilePictureTapped() {
            
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { [weak self] action in
            self?.presentImagePicker(source: .camera)
        })
            
        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .default, handler:{ [weak  self] action in
            self?.presentImagePicker(source: .photoLibrary)
        })
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
        let actionSheet = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        actionSheet.addAction(actions: [cameraAction, photoAlbumAction, cancelAction])
            
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func post1Tapped() {
        print("post1 tapped")
    }
    
    @objc func post2Tapped() {
        print("post2 tapped")
    }
    
    @objc func post3Tapped() {
        print("post3 tapped")
    }
    
    @objc func followButtonTapped() {
        profileVM.getProfile() { [weak self] serviceResponse in
            
            if serviceResponse.isSuccess {
                if self?.profileVM.profile?.isFollowing == true {
                    self?.profileVM.unfollow(username: self?.profileVM.profile?.username) { [weak self] serviceResponse in
                        
                        if serviceResponse.isSuccess {
                            self?.profileInfoTableViewCell?.followingButton.setTitle("FOLLOW", for:.normal)
                            let currentCount = (self?.profileVM.profile?.followers ?? 0) - 1
                            self?.profileInfoTableViewCell?.followerCountLabel.text = "\(currentCount)"
                        }
                        else {
                            self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                              theme: .error,
                                              style: .bottom)
                        }
                    }
                }
                else {
                    self?.profileVM.follow(username: self?.profileVM.profile?.username) { [weak self] serviceResponse in
                        
                        if serviceResponse.isSuccess {
                            self?.profileInfoTableViewCell?.followingButton.setTitle("UNFOLLOW", for:.normal)
                            let currentCount = (self?.profileVM.profile?.followers ?? 0) + 1
                            self?.profileInfoTableViewCell?.followerCountLabel.text = "\(currentCount)"
                        }
                        else {
                            self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                              theme: .error,
                                              style: .bottom)
                        }
                    }
                }
            }
            else {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }
    
    private func presentImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let controller = UIImagePickerController()
            controller.sourceType = source
            controller.delegate = self
            
            present(controller, animated: true, completion: nil)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    @objc override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profileImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileInfoTableViewCell?.profilePicture.setImage(profileImage, for: .normal)
        //send profile image here to server
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let postCount = profilePostsVM.posts?.count {
            if postCount % 3 != 0{
                return (postCount / 3) + 2
            }
            return (postCount / 3) + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profileInfoCellId) else {
                return UITableViewCell()
            }
            
            if let cell = cell as? ProfileInfoTableViewCell {
                
                if (UserInfo.shared.username != profileVM.profile?.username) {
                    cell.activateFollowButton(target: self, selector: #selector(followButtonTapped))
                    
                    profileVM.getProfile() { [weak self] serviceResponse in
                        if serviceResponse.isSuccess {
                            if self?.profileVM.profile?.isFollowing == true {
                                self?.profileInfoTableViewCell?.followingButton.setTitle("UNFOLLOW", for:.normal)
                            }
                            else {
                                self?.profileInfoTableViewCell?.followingButton.setTitle("FOLLOW", for:.normal)
                            }
                        }
                        else {
                            self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                                                theme: .error,
                                                                style: .bottom)
                        }
                     }
                } else {
                    cell.deactivateFollowButton()
                    cell.addTarget(target: self, selector: #selector(profilePictureTapped))
                }

                let error = cell.config(profileVM: profileVM, profilePostsCount: profilePostsVM.posts?.count)
                if error {
                    self.showMessage(body: "Invalid Request Info",
                                      theme: .error,
                                      style: .bottom)
                }
                profileInfoTableViewCell = cell
            }

            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profilePostsTableViewCellId) else {
                return UITableViewCell()
            }
            
            if let cell = cell as? ProfilePostsTableViewCell {
                if let postCount = profilePostsVM.posts?.count {
                    if postCount % 3 == 0 || indexPath.row != ((postCount / 3) + 1) {
                        cell.config1(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.config2(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.config3(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.addTarget1(target: self, selector: #selector(post1Tapped))
                        cell.addTarget2(target: self, selector: #selector(post2Tapped))
                        cell.addTarget3(target: self, selector: #selector(post3Tapped))
                    }
                    else if postCount % 3 == 1 {
                        cell.config1(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.addTarget1(target: self, selector: #selector(post1Tapped))
                        cell.deactivatePost2()
                        cell.deactivatePost3()
                    }
                    else if postCount % 3 == 2 {
                        cell.config1(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.config2(row: indexPath.row, profilePostsVM: self.profilePostsVM)
                        cell.addTarget1(target: self, selector: #selector(post1Tapped))
                        cell.addTarget2(target: self, selector: #selector(post2Tapped))
                        cell.deactivatePost3()
                    }
                }
            }
            return cell
        }
    }
}
