//
//  CommentsViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class CommentsViewModel: IGBaseViewModel {

    dynamic var comments: [Comment]?
    private var postID: String?

    init(postID: String?) {

        self.postID = postID
    }

    func getComments(completion: @escaping (ServiceResponse) -> Void) {

        if let postID = postID {

            CommentsViewService().getComments(postID: postID) { [weak self] serviceResponse, comments in

                if serviceResponse.isSuccess {

                    self?.comments = comments
                }
                completion(serviceResponse)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }

    func comment(comment: String?, completion: @escaping (ServiceResponse) -> Void) {

        if let comment = comment, let username = UserInfo.shared.username, let postID = postID {

            CommentsViewService().comment(username: username, comment: comment, postId: postID) { serviceResponse in

                completion(serviceResponse)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
