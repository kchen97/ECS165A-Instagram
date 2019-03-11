//
//  CommentsAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class CommentsAPIService: IGBaseAPIService {

    func comment(username: String,
                 comment: String,
                 postId: String) -> Promise<ServiceResponse> {

        return Promise { seal in

            self.comment(username: username, comment: comment, postId: postId) { response in
                seal.fulfill(response)
            }
        }
    }

    private func comment(username: String,
                         comment: String,
                         postId: String,
                         completion: @escaping (ServiceResponse) -> Void) {

        if let commentAPI = APIStorage.shared.commentAPI {

            let info = ["username": username,
                        "comment": comment,
                        "postID": postId]

            commentAPI.request(info: info, success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }

    func getComments(postID: String) -> Promise<(ServiceResponse, [Comment]?)> {

        return Promise { seal in

            self.getComments(postID: postID) { response, comments in
                seal.fulfill((response, comments))
            }
        }
    }

    private func getComments(postID: String,
                             completion: @escaping (ServiceResponse, [Comment]?) -> Void) {

        if let getCommentsAPI = APIStorage.shared.getCommentsAPI {

            getCommentsAPI.request(info: ["postID": postID], success: { (comments: [Comment]?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, comments)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
