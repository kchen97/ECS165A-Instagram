//
//  ProfileViewModel.swift
//  ecs165a-instagram
//
//  Created by Matthew Czajkowski on 2/12/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation
import UIKit

class ProfilePostsViewModel: IGBaseViewModel {

    dynamic var posts: [Post]?
    
    func getUserPosts(username: String?, completion: @escaping (ServiceResponse) -> Void) {
        if let username = username {
            ProfilePostsViewService().getUserPosts(username: username) { [weak self] serviceResponse, userPosts in
                
                if serviceResponse.isSuccess {
                    
                    self?.posts = userPosts
                    completion(serviceResponse)
                }
                else {
                    completion(serviceResponse)
                }
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
