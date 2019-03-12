//
//  SearchAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/25/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class SearchAPIService: IGBaseAPIService {

    func search(search: String) -> Promise<(ServiceResponse, SearchResults?)> {

        return Promise { seal in
            self.search(search: search) { serviceResponse, results in
                seal.fulfill((serviceResponse, results))
            }
        }
    }

    private func search(search: String,
                        completion: @escaping (ServiceResponse, SearchResults?) -> Void) {

        if let searchAPI = APIStorage.shared.searchAPI {

            searchAPI.request(info: ["search": search], success: { (results: SearchResults?) in

                let serviceResponse = ServiceResponse()
                serviceResponse.status = .success

                completion(serviceResponse, results)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
