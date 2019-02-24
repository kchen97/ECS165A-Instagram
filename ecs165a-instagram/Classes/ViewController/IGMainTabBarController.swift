//
//  IGMainTabBarController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/20/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class IGMainTabBarController: UITabBarController {

    private let profileScreen: UINavigationController = {

        let screen = UINavigationController(rootViewController: ProfileViewController())
        screen.tabBarItem.image = UIImage(named: "profile")
        return screen
    }()

    private let feedScreen: UINavigationController = {

        let screen = UINavigationController(rootViewController: FeedViewController())
        screen.tabBarItem.image = UIImage(named: "feed")
        return screen
    }()

    private let searchScreen: UINavigationController = {

        let screen = UINavigationController(rootViewController: SearchViewController())
        screen.tabBarItem.image = UIImage(named: "search")
        return screen
    }()

    override func viewDidLoad() {

        super.viewDidLoad()

        setup()
    }

    private func setup() {

        delegate = self
        tabBar.tintColor = .themeDarkGray

        setViewControllers([profileScreen, feedScreen, searchScreen],
                           animated: true)
    }
}

extension IGMainTabBarController: UITabBarControllerDelegate {
}
