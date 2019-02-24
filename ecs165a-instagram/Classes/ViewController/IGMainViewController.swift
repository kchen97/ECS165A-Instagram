//
//  IGMainViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class IGMainViewController: IGBaseViewController {

    override func setup() {

        super.setup()

        setNavBarButtons()
    }

    private func setNavBarButtons() {

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
        navigationController?.pushViewController(CreatePostViewController(), animated: true)
    }
}

extension IGMainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
    }
}
