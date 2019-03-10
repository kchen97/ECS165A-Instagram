//
//  ProfileViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class ProfileViewService: IGBaseViewService {

    func getProfile(username: String,
                    currentUser: String,
                    completion: @escaping (ServiceResponse, Profile?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            ProfileAPIService().getProfile(username: username, currentUser: currentUser)
                .done { serviceResponse, profile in

                    DispatchQueue.main.async {
                        completion(serviceResponse, profile)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure
                    serviceResponse.error = error

                    completion(serviceResponse, nil)
                }
        }
    }

    /// Username is the username of who the current user wants to follow
    func follow(username: String, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().follow(username: username)
                .done { serviceResponse in

                    DispatchQueue.main.async {
                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure
                    serviceResponse.error = error

                    completion(serviceResponse)
            }
        }
    }


    /// Username is the username of who the current user wants to unfollow
    func unfollow(username: String, completion: @escaping (ServiceResponse) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            FollowsAPIService().unfollow(username: username)
                .done { serviceResponse in

                    DispatchQueue.main.async {
                        completion(serviceResponse)
                    }
                }
                .catch { error in

                    let serviceResponse = ServiceResponse()
                    serviceResponse.status = .failure
                    serviceResponse.error = error

                    completion(serviceResponse)
            }
        }
    }

    func getPicture(url: String?, completion: @escaping (ServiceResponse, UIImage?) -> Void) {
        
        var picture: UIImage?
        
        DispatchQueue.global(qos: .userInitiated).async {
            
                firstly {
                    
                    when(fulfilled: self.getImages(url: url))
                }
                .done { results in
                        
                    for result in results where result.2 == url {
                            
                        picture = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                    DispatchQueue.main.async {
                        completion(self.serviceResponse, picture)
                    }
                    
                }
                .catch { error in
                    
                    let serviceResponse = ServiceResponse()
                    serviceResponse.error = error
                    serviceResponse.status = .failure
                    
                    completion(serviceResponse, nil)
            }
        }
    }
    
    private func getImages(url: String?) -> [Promise<(ServiceResponse, UIImage?, String)>] {
        
        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []
            
        if let link = url {
            promises.append(ImageAPIService().getImage(url: link))
        }
        return promises
    }
}
