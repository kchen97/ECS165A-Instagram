//
//  FeedViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class FeedViewModel: PostViewModel {

    dynamic var posts: [Post]?

    func getFeed(completion: @escaping (ServiceResponse) -> Void) {

        if let username = UserInfo.shared.username {

            FeedViewService().getFeed(username: username) { [weak self] serviceResponse, feed in

                if serviceResponse.isSuccess {
                    self?.posts = feed
                }
                completion(serviceResponse)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
