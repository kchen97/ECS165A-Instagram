//
//  UIViewController+Extensions.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

extension UIViewController {

    func setNavBarButtons() {

        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(settingsTapped))

        let postButton = UIBarButtonItem(image: UIImage(named: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(postTapped))

        settingsButton.tintColor = .themeDarkGray
        postButton.tintColor = .themeDarkGray

        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = postButton
    }

    @objc private func settingsTapped() {
        debugPrint("settings tapped")
    }

    @objc private func postTapped() {

        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
            debugPrint("Camera Tapped")
        })

        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .default, handler: { action in
            debugPrint("Photo Album Tapped")
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        let actionSheet = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        actionSheet.addAction(actions: [cameraAction, photoAlbumAction, cancelAction])

        present(actionSheet, animated: true, completion: nil)
    }
}
