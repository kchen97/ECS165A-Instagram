//
//  FollowsViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/13/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class FollowsViewService: IGBaseViewService {

    func followers(username: String,
                   completion: @escaping (ServiceResponse, [User]?) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().followers(username: username)
                .done { serviceResponse, users in

                    DispatchQueue.main.async {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        completion(serviceResponse, users)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.error = error
                    serviceResponse.status = .failure

                    completion(serviceResponse, nil)
                }
        }
    }

    func following(username: String,
                   completion: @escaping (ServiceResponse, [User]?) -> Void) {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().following(username: username)
                .done { serviceResponse, users in

                    DispatchQueue.main.async {

                        UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        completion(serviceResponse, users)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.error = error
                    serviceResponse.status = .failure

                    completion(serviceResponse, nil)
            }
        }
    }
}
