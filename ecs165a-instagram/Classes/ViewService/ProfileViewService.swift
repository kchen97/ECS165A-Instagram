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

                    for result in results {

                        if result.2 == post.imageLink {
                            post.image = result.1
                        }
                        else if result.2 == self.profile?.profilePictureLink {
                            self.profile?.picture = result.1
                        }
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

    func updateProfile(image: Data?,
                       bio: String?,
                       completion: @escaping (ServiceResponse) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            var requests: [Promise<ServiceResponse>] = []

            if let data = image {

                requests.append(ProfileAPIService().updatePicture(data: data))
            }

            if let bio = bio, !bio.isEmpty {

                requests.append(ProfileAPIService().updateBio(bio: bio))
            }

            when(fulfilled: requests)
                .done { responses in

                    for response in responses {
                        self.setServiceResponse(serviceResponse: response)
                    }
                    completion(self.serviceResponse)
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

            if let url = profile?.profilePictureLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
