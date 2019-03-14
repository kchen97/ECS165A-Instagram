//
//  FollowsViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/13/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class FollowsViewService: IGBaseViewService {

    private var users: [User]?

    func followers(username: String,
                   completion: @escaping (ServiceResponse, [User]?) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {
                FollowsAPIService().followers(username: username)
            }
            .then { (serviceResponse, users) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.users = users
                self.setServiceResponse(serviceResponse: serviceResponse)
                return when(fulfilled: self.getImages())
            }
            .done { results in

                for user in self.users ?? [] {

                    for result in results where result.2 == user.profilePicture {

                        user.picture = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }
                completion(self.serviceResponse, self.users)
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.users)
            }
        }
    }

    func following(username: String,
                   completion: @escaping (ServiceResponse, [User]?) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {
                FollowsAPIService().following(username: username)
            }
            .then { (serviceResponse, users) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.users = users
                self.setServiceResponse(serviceResponse: serviceResponse)
                return when(fulfilled: self.getImages())
            }
            .done { results in

                for user in self.users ?? [] {

                    for result in results where result.2 == user.profilePicture {

                        user.picture = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }
                completion(self.serviceResponse, self.users)
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.users)
            }
        }
    }

    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {

        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []

        for user in users ?? [] {

            if let url = user.profilePicture {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
