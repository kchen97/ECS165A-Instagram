//
//  FeedViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit
import UIKit

class FeedViewService: IGBaseViewService {

    private var posts: [Post]?

    func getFeed(username: String,
                 completion: @escaping (ServiceResponse, [Post]?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {

                FeedAPIService().getFeed(username: username)
            }
            .then { (serviceResponse, posts) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.posts = posts
                self.setServiceResponse(serviceResponse: serviceResponse)
                return when(fulfilled: self.getImages())
            }
            .done { results in

                for post in self.posts ?? [] {

                    for result in results {

                        if result.2 == post.imageLink {
                            post.image = result.1
                        }
                        else if result.2 == post.profilePictureLink {
                            post.profilePicture = result.1
                        }
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }
                completion(self.serviceResponse, self.posts)
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.posts)
            }
        }
    }

    /// Username is the username of the currently logged in user
    func likePost(postID: String, username: String, completion: @escaping (ServiceResponse) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            LikeAPIService().like(postID: postID, username: username)
                .done { serviceResponse in

                    DispatchQueue.main.async {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let response = ServiceResponse()
                    response.error = error
                    response.status = .failure

                    completion(response)
                }
        }
    }

    /// Username is the username of the currently logged in user
    func unlikePost(postID: String, username: String, completion: @escaping (ServiceResponse) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            LikeAPIService().unlike(postID: postID, username: username)
                .done { serviceResponse in

                    DispatchQueue.main.async {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let response = ServiceResponse()
                    response.error = error
                    response.status = .failure

                    completion(response)
            }
        }
    }

    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {

        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []

        for post in posts ?? [] {

            if let url = post.imageLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
            if let url = post.profilePictureLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
