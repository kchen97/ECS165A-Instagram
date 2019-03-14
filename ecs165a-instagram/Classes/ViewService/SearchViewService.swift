//
//  SearchViewService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/25/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit

class SearchViewService: IGBaseViewService {

    private var results: SearchResults?

    func search(search: String, completion: @escaping (ServiceResponse, SearchResults?) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async {

            firstly {

                SearchAPIService().search(search: search)
            }
            .then { (serviceResponse, results) -> Promise<[(ServiceResponse, UIImage?, String)]> in

                self.results = results
                self.setServiceResponse(serviceResponse: serviceResponse)
                return when(fulfilled: self.getImages())
            }
            .done { imageResults in

                for user in self.results?.users ?? [] {

                    for result in imageResults where result.2 == user.profilePicture {

                        user.picture = result.1
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }

                for post in self.results?.posts ?? [] {

                    for result in imageResults {

                        if result.2 == post.imageLink {
                            post.image = result.1
                        }
                        else if result.2 == post.profilePictureLink {
                            post.profilePicture = result.1
                        }
                        self.setServiceResponse(serviceResponse: result.0)
                    }
                }
                completion(self.serviceResponse, self.results)
            }
            .catch { error in

                let serviceResponse = ServiceResponse()
                serviceResponse.error = error
                serviceResponse.status = .failure

                completion(serviceResponse, self.results)
            }
        }
    }

    private func getImages() -> [Promise<(ServiceResponse, UIImage?, String)>] {

        var promises: [Promise<(ServiceResponse, UIImage?, String)>] = []

        for user in results?.users ?? [] {

            if let url = user.profilePicture {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }

        for post in results?.posts ?? [] {

            if let url = post.imageLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
            if let url = post.profilePictureLink {
                promises.append(ImageAPIService().getImage(url: url))
            }
        }
        return promises
    }
}
