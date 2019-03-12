//
//  PostViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class PostViewModel: IGBaseViewModel {

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

    func unlikePost(postID: String?,
                    completion: @escaping (ServiceResponse) -> Void) {

        if let postID = postID, let username = UserInfo.shared.username {

            FeedViewService().unlikePost(postID: postID, username: username) { serviceResponse in

                completion(serviceResponse)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
