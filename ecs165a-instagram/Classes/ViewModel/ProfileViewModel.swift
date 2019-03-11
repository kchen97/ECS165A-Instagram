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
    private var username: String?

    init(username: String? = UserInfo.shared.username) {

        self.username = username
    }
    
    func getProfile(completion: @escaping (ServiceResponse) -> Void) {
        
        if let username = self.username, let currentUser = UserInfo.shared.username {
            
            ProfileViewService().getProfile(username: username, currentUser: currentUser) { [weak self] serviceResponse, serverProfile in

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
    
    func getProfilePicture(link: String?, completion: @escaping (ServiceResponse) -> Void) {
        if let url = link {
            
            ProfileViewService().getPicture(url: url) { [weak self] serviceResponse, profilePicture in
                
                if serviceResponse.isSuccess {
                    self?.profile?.picture = profilePicture
                }
                else {
                    self?.profile?.picture = nil
                }
                completion(serviceResponse)
            }
        }
        else {
            
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
    
    /*func getPicture(link: String?, completion: @escaping (ServiceResponse, UIImage?) -> Void) {
        if let url = link {
            print(url)
            ProfileViewService().getPicture(url: url) { [weak self] serviceResponse, picture in
                
                if serviceResponse.isSuccess {
                    print("Herex")
                    self?.profile?.postContainer = picture
                    completion(serviceResponse, picture)
                }
                else {
                    print("here")
                    completion(serviceResponse, nil)
                }
            }
        }
        else {
            print("url bad")
            completion(ServiceResponse.getInvalidRequestServiceResponse(), nil)
        }
    }*/

}
