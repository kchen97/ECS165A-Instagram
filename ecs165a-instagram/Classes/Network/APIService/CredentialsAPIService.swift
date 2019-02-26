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

        if let signUpAPI = APIStorage.shared.signUpAPI {

            signUpAPI.request(info: user.toJSON(),
                              success: { (token: AuthToken?) in

                let response = ServiceResponse()
                response.status = .success

                UserInfo.shared.username = token?.username

                completion(response, token)
            },
            failure: { response in

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

        if let loginAPI = APIStorage.shared.loginAPI {

            loginAPI.request(info: user.toJSON(),
                             success: { (token: AuthToken?) in

                let response = ServiceResponse()
                response.status = .success

                UserInfo.shared.username = token?.username

                completion(response, token)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
