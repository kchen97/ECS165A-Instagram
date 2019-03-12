//
//  SearchViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class SearchViewModel: PostViewModel {

    dynamic var results: SearchResults?

    func search(search: String?,
                completion: @escaping (ServiceResponse) -> Void) {

        if let search = search {

            SearchViewService().search(search: search) { [weak self] serviceResponse, results in

                if serviceResponse.isSuccess {
                    self?.results = results
                }
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
