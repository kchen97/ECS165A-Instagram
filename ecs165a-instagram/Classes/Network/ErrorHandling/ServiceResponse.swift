//
//  ServiceResponse.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

enum Status {
    case success, failure
}

class ServiceResponse {

    var errorMessage: String?
    var status: Status!
    var error: Error?

    var isSuccess: Bool {
        return status == .success
    }

    static func getInvalidRequestServiceResponse() -> ServiceResponse {

        let serviceResponse = ServiceResponse()
        serviceResponse.status = .failure
        serviceResponse.errorMessage = "Invalid request parameters"

        return serviceResponse
    }
}
