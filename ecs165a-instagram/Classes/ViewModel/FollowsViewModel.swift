//
//  FollowsViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/13/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class FollowsViewModel: IGBaseViewModel {

    dynamic var users: [User]?
    private var username: String?

    init(username: String?) {

        self.username = username
    }

    func followers(completion: @escaping (ServiceResponse) -> Void) {

        if let username = username {

            FollowsViewService().followers(username: username) { [weak self] response, users in

                if response.isSuccess {
                    self?.users = users
                }
                completion(response)
            }
        }
    }

    func following(completion: @escaping (ServiceResponse) -> Void) {

        if let username = username {

            FollowsViewService().following(username: username) { [weak self] response, users in

                if response.isSuccess {
                    self?.users = users
                }
                completion(response)
            }
        }
    }
}
