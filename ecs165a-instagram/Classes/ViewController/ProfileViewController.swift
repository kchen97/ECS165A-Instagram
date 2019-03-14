//
//  ProfileViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import Blueprints

class ProfileViewController: IGMainViewController {

    var enableSettingsAndCreatePost: Bool = true
    var profileVM = ProfileViewModel()

    private let postCellID = "postCellID"
    private let profileInfoHeaderViewID = "profileInfoHeaderViewID"

    private var headerView: ProfileInfoHeaderView?

    private let collectionView: UICollectionView = {

        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 2,
            height: 300,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            stickyHeaders: false,
            stickyFooters: false
        )
        blueprintLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 180)

        let view = UICollectionView(frame: .zero, collectionViewLayout: blueprintLayout)
        view.backgroundColor = .white

        return view
    }()
    
    private let ROW_HEIGHT: CGFloat = 200

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        loadData()
    }

    private func loadData() {

        showSpinner(message: "Loading...")

        profileVM.getProfile { [weak self] serviceResponse in

            self?.stopSpinner()
            self?.navigationItem.title = self?.profileVM.profile?.username

            if serviceResponse.isSuccess {
                self?.collectionView.reloadData()
            }
            else {
                self?.showMessage(body: serviceResponse.errorMessage ?? "",
                                  theme: .error,
                                  style: .bottom)
            }
        }
    }

    override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()

        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func setup() {
        
        super.setup()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(PostCollectionViewCell.self,
                                forCellWithReuseIdentifier: postCellID)
        collectionView.register(ProfileInfoHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: profileInfoHeaderViewID)

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }

        if enableSettingsAndCreatePost {
            setNavBarButtons()
        }
        else {
            navigationController?.navigationBar.tintColor = .themeDarkGray
        }
    }

    private func follow() {

        showSpinner(message: "Saving...")

        profileVM.follow { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "", theme: .error, style: .bottom)
            }
            else {
                self?.loadData()
            }
        }
    }

    private func unfollow() {

        showSpinner(message: "Saving...")

        profileVM.unfollow { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "", theme: .error, style: .bottom)
            }
            else {
                self?.loadData()
            }
        }
    }

    private func updateProfile(image: UIImage?, bio: String?) {

        showSpinner(message: "Saving...")

        profileVM.updateProfile(image: image?.jpegData(compressionQuality: 0.2), bio: bio) { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {
                self?.showMessage(body: serviceResponse.errorMessage ?? "", theme: .error, style: .bottom)
            }
            else {
                self?.loadData()
            }
        }
    }

    private func showFollowsScreen(type: FollowsType) {

        let followsScreen = FollowsViewController()
        followsScreen.followsVM = FollowsViewModel(username: profileVM.profile?.username)
        followsScreen.type = type

        navigationController?.pushViewController(followsScreen, animated: true)
    }

    @objc private func addImage() {

        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { [weak self] action in
            self?.presentImagePicker(source: .camera)
        })

        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .default, handler: { [weak self] action in
            self?.presentImagePicker(source: .photoLibrary)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        let actionSheet = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        actionSheet.addAction(actions: [cameraAction, photoAlbumAction, cancelAction])

        present(actionSheet, animated: true, completion: nil)
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: ImagePickerController Delegates
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        headerView?.editProfileView.config(image: info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
        dismiss(animated: true, completion: nil)
    }

    // MARK: UICollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return profileVM.profile?.userPosts?.isEmpty == false ? (profileVM.profile?.userPosts?.count ?? 0) : 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: profileInfoHeaderViewID,
                                                                   for: indexPath)

        if let view = view as? ProfileInfoHeaderView {

            view.config(name: profileVM.profile?.username,
                        caption: profileVM.profile?.biography,
                        posts: profileVM.profile?.posts,
                        followers: profileVM.profile?.followers,
                        following: profileVM.profile?.following,
                        picture: profileVM.profile?.picture)

            if !profileVM.isSelf {

                view.followTapped = {  [weak self] in

                    if self?.profileVM.profile?.isFollowing == true {
                        self?.unfollow()
                    }
                    else {
                        self?.follow()
                    }
                }
            }
            else {

                view.editPictureTapped = { [weak self] in
                    self?.addImage()
                }

                view.saveProfileTapped = { [weak self] image, text in
                    self?.updateProfile(image: image, bio: text)
                }
            }

            view.followersTapped = { [weak self] in
                self?.showFollowsScreen(type: .followers)
            }

            view.followingTapped = { [weak self] in
                self?.showFollowsScreen(type: .following)
            }

            view.followed = profileVM.profile?.isFollowing == true
            headerView = view
        }
        return view
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellID, for: indexPath)

        guard profileVM.profile?.userPosts?.isEmpty == false else {

            cell.isHidden = true
            return cell
        }

        cell.isHidden = false

        if let cell = cell as? PostCollectionViewCell {

            cell.config(image: profileVM.profile?.userPosts?[indexPath.row].image)
        }
        return cell
    }
}
