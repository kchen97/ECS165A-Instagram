//
//  ProfileViewModel.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/12/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class ProfileViewModel: IGBaseViewModel{

    var isOwnerProfile: Bool {
        return username == UserInfo.shared.username
    }
    var profile: Profile?

    private var username: String?

    init(username: String? = UserInfo.shared.username) {

        self.username = username
    }
    
    func getProfile(completion: @escaping (ServiceResponse) -> Void) {
        
        if let username = self.username {
            
            ProfileViewService().getProfile(username: username) { [weak self] serviceResponse, serverProfile in

                self?.profile = serverProfile
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
