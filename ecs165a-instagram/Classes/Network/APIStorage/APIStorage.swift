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

    lazy var saveHelloWorldAPI: NetworkDataClient? = NetworkDataClient(endpoint: saveHelloWorldEndpoint)
    lazy var getHelloWorldAPI: NetworkDataClient? = NetworkDataClient(endpoint: getHelloWorldEndpoint)
}
