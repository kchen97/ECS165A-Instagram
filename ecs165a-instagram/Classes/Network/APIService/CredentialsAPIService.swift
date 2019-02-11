//
//  CredentialsAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class CredentialsAPIService: IGBaseAPIService {

    func signUp(user: User) -> Promise<(ServiceResponse, AuthToken?)> {

        return Promise { seal in
            self.signUp(user: user) { serviceResponse, token in
                seal.fulfill((serviceResponse, token))
            }
        }
    }

    private func signUp(user: User,
                        completion: @escaping (ServiceResponse, AuthToken?) -> Void) {

        if let signUpAPI = APIStorage.storage.signUpAPI {

            signUpAPI.request(info: user.toJSON(),
                              success: { (token: AuthToken?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, token)
            },
            failure: {

                let response = ServiceResponse()
                response.status = .failure
                response.errorMessage = "We were unable to connect at this moment. Please try again later."

                completion(response, nil)
            })
        }
    }

    func login(user: User) -> Promise<(ServiceResponse, AuthToken?)> {

        return Promise { seal in
            self.login(user: user) { serviceResponse, token in
                seal.fulfill((serviceResponse, token))
            }
        }
    }

    private func login(user: User,
                       completion: @escaping (ServiceResponse, AuthToken?) -> Void) {

        if let loginAPI = APIStorage.storage.loginAPI {

            loginAPI.request(info: user.toJSON(), success: { (token: AuthToken?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, token)
            },
            failure: {

                let response = ServiceResponse()
                response.status = .failure
                response.errorMessage = "We were unable to connect at this moment. Please try again later."

                completion(response, nil)
            })
        }
    }
}
