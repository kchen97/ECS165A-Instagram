//
//  ImageAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/26/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import PromiseKit
import Alamofire
import UIKit

class ImageAPIService: IGBaseAPIService {

    func getImage(url: String) -> Promise<(ServiceResponse, UIImage?, String)> {

        return Promise { seal in
            self.getImage(url: url) { serviceResponse, image in
                seal.fulfill((serviceResponse, image, url))
            }
        }
    }

    private func getImage(url: String,
                          completion: @escaping (ServiceResponse, UIImage?) -> Void) {

        let imageAPI = NetworkDataClient(endpoint: (path: url, method: .get, encoding: URLEncoding.default))

        imageAPI.download(info: nil,
                          success: { image in

            let serviceResponse = ServiceResponse()
            serviceResponse.status = .success

            completion(serviceResponse, image)
        },
        failure: {

            let serviceResponse = ServiceResponse()
            serviceResponse.status = .failure
            serviceResponse.errorMessage = "Request failed with url: \(url)"

            completion(serviceResponse, nil)
        })
    }
}
