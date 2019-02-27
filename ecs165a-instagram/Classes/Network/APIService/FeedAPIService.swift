//
//  FeedAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class FeedAPIService: IGBaseAPIService {

    func getFeed(username: String) -> Promise<(ServiceResponse, [Post]?)> {

        return Promise { seal in
            self.getFeed(username: username) { serviceResponse, posts in
                seal.fulfill((serviceResponse, posts))
            }
        }
    }

    private func getFeed(username: String,
                         completion: @escaping (ServiceResponse, [Post]?) -> Void) {

        if let feedAPI = APIStorage.shared.feedAPI {

            feedAPI.request(info: ["username": username], success: { (posts: [Post]?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, posts)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
