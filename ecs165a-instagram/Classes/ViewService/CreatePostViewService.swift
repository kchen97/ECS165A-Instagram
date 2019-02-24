//
//  CreatePostViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class CreatePostViewService: IGBaseViewService {

    func createPost(post: Post, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            PostsAPIService().createPost(post: post)
                .done { serviceResponse in

                    DispatchQueue.main.async {
                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure
                    serviceResponse.error = error

                    completion(serviceResponse)
                }
        }
    }
}
