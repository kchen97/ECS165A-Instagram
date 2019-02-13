//
//  ProfileViewModel.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/12/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class ProfileViewModel: IGBaseViewModel{
    
    var profile: Profile?
    
    func getProfile(completion: @escaping (ServiceResponse) -> Void) {
        
        if let username = UserInfo.shared.username {
            
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
