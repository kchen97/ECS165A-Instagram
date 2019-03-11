//
//  LikeAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class LikeAPIService: IGBaseAPIService {

    /// Username is the current logged in user
    func like(postID: String, username: String) -> Promise<(ServiceResponse)> {

        return Promise { seal in

            self.like(postID: postID, username: username) { response in
                seal.fulfill(response)
            }
        }
    }

    private func like(postID: String, username: String, completion: @escaping (ServiceResponse) -> Void) {

        if let likeAPI = APIStorage.shared.likeAPI {

            likeAPI.request(info: ["postID": postID,
                                   "username": username], success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }
}
