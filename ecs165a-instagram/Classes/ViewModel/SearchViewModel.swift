//
//  SearchViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

@objcMembers class SearchViewModel: IGBaseViewModel {
    
    dynamic var users: [User]?

    func search(username: String?,
                completion: @escaping (ServiceResponse) -> Void) {

        if let username = username {

            SearchViewService().search(username: username) { [weak self] serviceResponse, users in

                if serviceResponse.isSuccess {
                    self?.users = users
                }
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
