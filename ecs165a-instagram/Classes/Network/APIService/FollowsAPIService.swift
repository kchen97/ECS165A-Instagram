//
//  FollowsAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class FollowsAPIService: IGBaseAPIService {

    /// Username is the username to follow
    func follow(username: String) -> Promise<(ServiceResponse)> {

        return Promise { seal in
            self.follow(username: username) { response in
                seal.fulfill(response)
            }
        }
    }

    private func follow(username: String,
                        completion: @escaping (ServiceResponse) -> Void) {

        if let followsAPI = APIStorage.shared.followsAPI {

            followsAPI.request(info: ["username": username,
                                      "follower": UserInfo.shared.username], success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }

    /// Username is the username to unfollow
    func unfollow(username: String) -> Promise<(ServiceResponse)> {

        return Promise { seal in
            self.unfollow(username: username) { response in
                seal.fulfill(response)
            }
        }
    }

    private func unfollow(username: String,
                          completion: @escaping (ServiceResponse) -> Void) {

        if let unfollowsAPI = APIStorage.shared.unfollowsAPI {

            unfollowsAPI.request(info: ["unfollowed": username,
                                        "unfollower": UserInfo.shared.username], success: {

                let response = ServiceResponse()
                response.status = .success

                completion(response)
            },
            failure: { response in

                completion(response)
            })
        }
    }

    /// Username is the user who followers will be returned for
    func followers(username: String) -> Promise<(ServiceResponse, [User]?)> {

        return Promise { seal in

            self.followers(username: username) { response, users in
                seal.fulfill((response, users))
            }
        }
    }

    private func followers(username: String,
                           completion: @escaping (ServiceResponse, [User]?) -> Void) {

        if let followersAPI = APIStorage.shared.followersAPI {

            followersAPI.request(info: ["username": username], success: { (users: [User]?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, users)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }

    /// Username is the user who following will be returned for
    func following(username: String) -> Promise<(ServiceResponse, [User]?)> {

        return Promise { seal in

            self.following(username: username) { response, users in
                seal.fulfill((response, users))
            }
        }
    }

    private func following(username: String,
                           completion: @escaping (ServiceResponse, [User]?) -> Void) {

        if let followingAPI = APIStorage.shared.followingAPI {

            followingAPI.request(info: ["username": username], success: { (users: [User]?) in

                let response = ServiceResponse()
                response.status = .success

                completion(response, users)
            },
            failure: { response in

                completion(response, nil)
            })
        }
    }
}
