//
//  CommentsViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class CommentsViewService: IGBaseViewService {

    private var comments: [Comment]?

    func comment(username: String,
                 comment: String,
                 postId: String,
                 completion: @escaping (ServiceResponse) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            CommentsAPIService().comment(username: username, comment: comment, postId: postId)
                .done { response in

                    DispatchQueue.main.async {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        completion(response)
                    }
                }
                .catch { error in

                    let response = ServiceResponse()
                    response.status = .failure
                    response.error = error

                    completion(response)
                }
        }
    }

    func getComments(postID: String,
                     completion: @escaping (ServiceResponse, [Comment]?) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {

                CommentsAPIService().getComments(postID: postID)
            }
            .then { (serviceResponse, comments) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.comments = comments
                self.setServiceResponse(serviceResponse: serviceResponse)
                return when(fulfilled: self.getImages())
            }
            .done { results in

                for comment in self.comments ?? [] {

                    for result in results where result.2 == comment.profilePicture {

                        comment.picture = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }

                DispatchQueue.main.async {

                    UIApplication.shared.isNetworkActivityIndicatorVisible = false

                    completion(self.serviceResponse, self.comments)
                }
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.comments)
            }
        }
    }

    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {

        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []

        for comment in comments ?? [] {

            if let url = comment.profilePicture {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
