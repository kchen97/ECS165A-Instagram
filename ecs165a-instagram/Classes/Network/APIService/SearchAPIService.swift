//
//  SearchAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/25/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class SearchAPIService: IGBaseAPIService {

    func search(username: String) -> Promise<(ServiceResponse, [User]?)> {

        return Promise { seal in
            self.search(username: username) { serviceResponse, users in
                seal.fulfill((serviceResponse, users))
            }
        }
    }

    private func search(username: String,
                        completion: @escaping (ServiceResponse, [User]?) -> Void) {

        if let searchAPI = APIStorage.shared.searchAPI {

            searchAPI.request(info: ["search": username], success: { (users: [User]?) in

                let serviceResponse = ServiceResponse()
                serviceResponse.status = .success

                completion(serviceResponse, users)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
