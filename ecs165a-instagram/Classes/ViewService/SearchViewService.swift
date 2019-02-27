//
//  SearchViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/25/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class SearchViewService: IGBaseViewService {

    func search(username: String, completion: @escaping (ServiceResponse, [User]?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            SearchAPIService().search(username: username)
                .done { serviceResponse, users in

                    DispatchQueue.main.async {
                        completion(serviceResponse, users)
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
