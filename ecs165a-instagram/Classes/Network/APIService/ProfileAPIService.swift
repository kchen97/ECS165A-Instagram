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

    func updatePicture(data: Data) -> Promise<(ServiceResponse)> {

        return Promise { seal in

            self.updatePicture(data: data) { serviceResponse in
                seal.fulfill(serviceResponse)
            }
        }
    }

    private func updatePicture(data: Data, completion: @escaping (ServiceResponse) -> Void) {

        if let updatePictureAPI = APIStorage.shared.updateProfilePictureAPI {

            updatePictureAPI.upload(info: ["username": UserInfo.shared.username ?? "",
                                           "image": data],
                                    success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }

    func updateBio(bio: String) -> Promise<ServiceResponse> {

        return Promise { seal in

            self.updateBio(bio: bio) { response in
                seal.fulfill(response)
            }
        }
    }

    private func updateBio(bio: String, completion: @escaping (ServiceResponse) -> Void) {

        if let updateBioAPI = APIStorage.shared.updateBioAPI {

            updateBioAPI.request(info: ["username": UserInfo.shared.username ?? "",
                                        "bio": bio],
                                 success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }
}
