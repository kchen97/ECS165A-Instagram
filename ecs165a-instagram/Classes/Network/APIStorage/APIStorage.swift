//
//  APIStorage.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

final class APIStorage {

    static let shared = APIStorage()

    lazy var signUpAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_SIGN_UP_ENDPOINT)
    lazy var loginAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_LOGIN_ENDPOINT)

    lazy var getProfileAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_PROFILE_ENDPOINT)

    lazy var postAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_POST_ENDPOINT)
    lazy var getPostAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_GET_POST_ENDPOINT)
}
