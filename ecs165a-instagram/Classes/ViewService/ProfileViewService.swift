//
//  ProfileViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class ProfileViewService: IGBaseViewService {

    func getProfile(username: String, completion: @escaping (ServiceResponse, Profile?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            ProfileAPIService().getProfile(username: username)
                .done { serviceResponse, profile in

                    DispatchQueue.main.async {
                        completion(serviceResponse, profile)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure
                    serviceResponse.error = error

                    completion(serviceResponse, nil)
                }
        }
    }
}
