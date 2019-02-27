//
//  ProfileAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class ProfileAPIService: IGBaseAPIService {

    func getProfile(username: String, currentUser: String) -> Promise<(ServiceResponse, Profile?)> {
        return Promise { seal in
            self.getProfile(username: username, currentUser: currentUser) { serviceResponse, profile in
                seal.fulfill((serviceResponse, profile))
            }
        }
    }

    private func getProfile(username: String,
                            currentUser: String,
                            completion: @escaping (ServiceResponse, Profile?) -> Void) {

        if let getProfileAPI = APIStorage.shared.getProfileAPI  {

            getProfileAPI.request(info: ["username": username,
                                         "loggedInUser": currentUser],
                                  success: { (profile: Profile?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, profile)

            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
