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

let kMultiPartFormDataHeaders = ["Content-type": "multipart/form-data"]

// MAIN
let IG_BASE_URI_PATH = "https://insta-b5cb5.appspot.com/api"

// LOCAL
//let IG_BASE_URI_PATH = "http://localhost:4000/api"

let IG_SIGN_UP_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/signup", method: .post, encoding: JSONEncoding.default)
let IG_LOGIN_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/login", method: .post, encoding: JSONEncoding.default)

let IG_PROFILE_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/profile", method: .get, encoding: URLEncoding.default)

let IG_POST_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/posts", method: .post, encoding: JSONEncoding.default)
let IG_GET_POST_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/posts", method: .post, encoding: URLEncoding.default)

let IG_SEARCH_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/search", method: .get, encoding: URLEncoding.default)

let IG_FEED_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/feed", method: .get, encoding: URLEncoding.default)

let IG_FOLLOW_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/follows", method: .post, encoding: JSONEncoding.default)
let IG_UNFOLLOW_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/follows/unfollow", method: .post, encoding: JSONEncoding.default)

let IG_COMMENT_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/comments", method: .patch, encoding: JSONEncoding.default)
let IG_GET_COMMENTS_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/comments", method: .get, encoding: URLEncoding.default)

let IG_LIKE_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/likes", method: .patch, encoding: JSONEncoding.default)
let IG_UNLIKE_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/likes", method: .delete, encoding: JSONEncoding.default)

let IG_UPDATE_PROFILE_PICTURE_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/profile/updateProfilePic", method: .post, encoding: JSONEncoding.default)
let IG_UPDATE_BIO_ENDPOINT: Endpoint = (path: IG_BASE_URI_PATH + "/profile/updateBio", method: .post, encoding: JSONEncoding.default)
