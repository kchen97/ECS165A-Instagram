//
//  ProfileViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class ProfileViewController: IGMainViewController {

    let profileVM = ProfileViewModel()
    
    private var profileInfoTableViewCell: ProfileInfoTableViewCell?
    private let profileInfoCellId = "profileInfoCellId"
    private let profilePostsTableViewCellId = "profilePostsTableViewCellId"
    
    private let tableview = UITableView()
    
    private let ROW_HEIGHT: CGFloat = 200

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        profileVM.getProfile { [weak self] serviceResponse in

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

        if profileVM.isOwnerProfile {
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
        print("Follow Button Tapped")
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
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        profileInfoTableViewCell?.profilePicture.setBackgroundImage(info[UIImagePickerController.InfoKey.originalImage] as? UIImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let postCount = profileVM.profile?.posts {
            return (postCount / 3) + 2
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
                
                cell.config(name: profileVM.profile?.fullName,
                            caption: profileVM.profile?.biography,
                            posts: profileVM.profile?.posts,
                            followers: profileVM.profile?.followers,
                            following: profileVM.profile?.following,
                            profileImage: profileVM.profile?.profileImage)
                cell.addTarget(target: self, selector: #selector(profilePictureTapped))
                //fix button
                if profileVM.validate(currentUserPage: profileVM.profile?.username) {
                    cell.activateFollowButton(target: self, selector: #selector(followButtonTapped))
                } else {
                    cell.deactivateFollowButton()
                }
                profileInfoTableViewCell = cell
            }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profilePostsTableViewCellId) else {
                return UITableViewCell()
            }
            
            if let cell = cell as? ProfilePostsTableViewCell {
                cell.config()
                cell.addTarget1(target: self, selector: #selector(post1Tapped))
                cell.addTarget2(target: self, selector: #selector(post2Tapped))
                cell.addTarget3(target: self, selector: #selector(post3Tapped))
            }
            
            return cell
        }
    }
}
