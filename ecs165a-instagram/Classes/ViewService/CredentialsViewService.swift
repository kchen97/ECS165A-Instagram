//
//  CredentialsViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class CredentialsViewService: IGBaseViewService {

    func signUp(user: User, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {
            CredentialsAPIService().signUp(user: user)
                .done { serviceResponse, token in

                    DispatchQueue.main.async {

                        if serviceResponse.isSuccess {
                            IGBaseViewService.authToken = token
                        }
                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure

                    debugPrint(error)

                    completion(serviceResponse)
                }
        }
    }

    func login(user: User, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {
            CredentialsAPIService().login(user: user)
                .done { serviceResponse, token in
                    DispatchQueue.main.async {

                        if serviceResponse.isSuccess {
                            IGBaseViewService.authToken = token
                        }
                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure

                    debugPrint(error)

                    completion(serviceResponse)
                }
        }
    }
}
