//
//  ProfileViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class ProfileViewService: IGBaseViewService {

    private var profile: Profile?

    func getProfile(username: String,
                    currentUser: String,
                    completion: @escaping (ServiceResponse, Profile?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {

                ProfileAPIService().getProfile(username: username, currentUser: currentUser)
            }
            .then { (serviceResponse, profile) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.profile = profile
                return when(fulfilled: self.getImages())
            }
            .done { results in

                let serviceResponse = ServiceResponse()
                serviceResponse.status = .success

                self.setServiceResponse(serviceResponse: serviceResponse)

                for post in self.profile?.userPosts ?? [] {

                    for result in results where result.2 == post.imageLink {

                        post.image = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }
                completion(self.serviceResponse, self.profile)
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.profile)
            }
        }
    }

    /// Username is the username of who the current user wants to follow
    func follow(username: String, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().follow(username: username)
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


    /// Username is the username of who the current user wants to unfollow
    func unfollow(username: String, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().unfollow(username: username)
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

    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {

        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []

        for post in profile?.userPosts ?? [] {

            if let url = post.imageLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
