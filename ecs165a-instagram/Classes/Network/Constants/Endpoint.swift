//
//  Endpoint.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Alamofire

typealias Endpoint = (path: String, method: HTTPMethod, encoding: ParameterEncoding)

/*
 **
 ***
 **** Endpoints
 ***
 **
 */

let saveHelloWorldEndpoint: Endpoint = (path: "helloWorld/user/{name}", method: .post, encoding: URLEncoding.default)
let getHelloWorldEndpoint: Endpoint = (path: "helloWorld/user/{name}", method: .get, encoding: URLEncoding.default)
