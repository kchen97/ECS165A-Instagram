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

    private let collectionView: UICollectionView = {

        let blueprintLayout = VerticalBlueprintLayout(
            itemsPerRow: 2.0,
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

    private func follow(completion: @escaping (Bool) -> Void) {

        showSpinner(message: "Following...")

        profileVM.follow { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {

                self?.showMessage(body: serviceResponse.errorMessage ?? "", theme: .error, style: .bottom)
            }
            completion(serviceResponse.isSuccess)
        }
    }

    private func unfollow(completion: @escaping (Bool) -> Void) {

        showSpinner(message: "Following...")

        profileVM.unfollow { [weak self] serviceResponse in

            self?.stopSpinner()

            if !serviceResponse.isSuccess {

                self?.showMessage(body: serviceResponse.errorMessage ?? "", theme: .error, style: .bottom)
            }
            completion(serviceResponse.isSuccess)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return profileVM.profile?.userPosts?.count ?? 0
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

                        self?.unfollow { success in
                            view.followed = success == false
                        }
                    }
                    else {

                        self?.follow { success in
                            view.followed = success
                        }
                    }
                }
            }
            view.followed = profileVM.profile?.isFollowing == true
        }
        return view
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellID, for: indexPath)

        if let cell = cell as? PostCollectionViewCell {

            cell.config(image: profileVM.profile?.userPosts?[indexPath.row].image)
        }
        return cell
    }
}
