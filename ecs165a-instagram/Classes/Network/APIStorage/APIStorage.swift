//
//  APIStorage.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

final class APIStorage {

    static let storage = APIStorage()

    lazy var signUpAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_SIGN_UP_ENDPOINT)
    lazy var loginAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_LOGIN_ENDPOINT)

    lazy var profileAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_PROFILE_ENDPOINT)
}
