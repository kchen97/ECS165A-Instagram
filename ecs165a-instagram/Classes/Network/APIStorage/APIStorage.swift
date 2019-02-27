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

    lazy var postAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_POST_ENDPOINT, headers: kMultiPartFormDataHeaders)
    lazy var getPostAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_GET_POST_ENDPOINT)

    lazy var searchAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_SEARCH_ENDPOINT)

    lazy var feedAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_FEED_ENDPOINT)

    lazy var followsAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_FOLLOW_ENDPOINT)
    lazy var unfollowsAPI: NetworkDataClient? = NetworkDataClient(endpoint: IG_UNFOLLOW_ENDPOINT)
}
