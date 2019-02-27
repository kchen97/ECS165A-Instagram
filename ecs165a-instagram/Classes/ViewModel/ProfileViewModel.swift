//
//  ProfileViewModel.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/12/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: IGBaseViewModel{

    var profile: Profile?
    var isUser: Bool?
    private var username: String?

    init(username: String? = UserInfo.shared.username, isUser: Bool?) {

        self.username = username
        self.isUser = isUser
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

    /// Username is the username of who the current user wants to follow
    func follow(username: String?, completion: @escaping (ServiceResponse) -> Void) {

        if let _ = UserInfo.shared.username, let userToFollow = username {

            ProfileViewService().follow(username: userToFollow) { response in

                completion(response)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }

    /// Username is the username of who the current user wants to unfollow
    func unfollow(username: String?, completion: @escaping (ServiceResponse) -> Void) {

        if let _ = UserInfo.shared.username, let userToFollow = username {

            ProfileViewService().unfollow(username: userToFollow) { response in

                completion(response)
            }
        }
        else {

            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
