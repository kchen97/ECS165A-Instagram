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

let IG_BASE_URI_PATH = "https://insta-b5cb5.appspot.com/api"

let IG_SIGN_UP_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/signup", method: .post, encoding: JSONEncoding.default)
let IG_LOGIN_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/login", method: .post, encoding: JSONEncoding.default)

let IG_PROFILE_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/profile", method: .get, encoding: URLEncoding.default)

let IG_POST_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/posts", method: .post, encoding: JSONEncoding.default)
let IG_GET_POST_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/posts", method: .post, encoding: URLEncoding.default)
