//
//  ProfileViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class ProfilePostsViewService: IGBaseViewService {
    
    private var posts: [Post]?
    
    func getUserPosts(username: String,
                 completion: @escaping (ServiceResponse, [Post]?) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {

            firstly {
                
                ProfileAPIService().getProfile(username: username, currentUser: UserInfo.shared.username ?? "")
                }
                .then { (serviceResponse, profile) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                    self.posts = profile?.userPosts
                    self.setServiceResponse(serviceResponse: serviceResponse)
                    return when(fulfilled: self.getImages())
                }
                .done { results in
                    
                    for post in self.posts ?? [] {
                        
                        for result in results where result.2 == post.imageLink {

                            post.image = result.1
                            self.setServiceResponse(serviceResponse: result.0)
                        }
                    }
                    completion(self.serviceResponse, self.posts)
                }
                .catch { error in
                    
                    let serviceResponse = ServiceResponse()
                    serviceResponse.error = error
                    serviceResponse.status = .failure
                    
                    completion(serviceResponse, self.posts)
            }
        }
    }
    
    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {
        
        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []
        
        for post in posts ?? [] {
            
            if let url = post.imageLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
