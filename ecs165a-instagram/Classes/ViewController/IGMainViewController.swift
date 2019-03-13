//
//  IGMainViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class IGMainViewController: IGBaseViewController {

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

        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            self?.tabBarController?.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(actions: [logoutAction, cancelAction])

        present(actionSheet, animated: true, completion: nil)
    }

    @objc private func postTapped() {
        navigationController?.pushViewController(CreatePostViewController(), animated: true)
    }
}

extension IGMainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
    }
}
