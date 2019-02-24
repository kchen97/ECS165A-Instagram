//
//  PostsAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class PostsAPIService: IGBaseAPIService {

    func createPost(post: Post) -> Promise<ServiceResponse> {

        return Promise { seal in
            self.createPost(post: post, completion: { serviceResponse in
                seal.fulfill(serviceResponse)
            })
        }
    }

    private func createPost(post: Post, completion: @escaping (ServiceResponse) -> Void) {

        if let postAPI = APIStorage.shared.postAPI {

            postAPI.request(info: post.toJSON(), success: {

                let serviceResponse = ServiceResponse()
                serviceResponse.status = .success

                completion(serviceResponse)
            },
            failure: {

                let serviceResponse = ServiceResponse()
                serviceResponse.status = .failure
                serviceResponse.errorMessage = "Unable to create the post. Please try again."

                completion(serviceResponse)
            })
        }
    }
}
