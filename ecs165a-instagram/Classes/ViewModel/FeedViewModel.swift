//
//  FeedViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class FeedViewModel: IGBaseViewModel {

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

    func likePost(postID: String?,
                  completion: @escaping (ServiceResponse) -> Void) {

        if let postID = postID, let username = UserInfo.shared.username {

            FeedViewService().likePost(postID: postID, username: username) { serviceResponse in

                completion(serviceResponse)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
