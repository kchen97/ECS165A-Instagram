//
//  NetworkDataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Alamofire

class NetworkDataClient: DataClient {

    private var endpoint: Endpoint!
    private var headers: HTTPHeaders?
    private var parameters: Parameters?

    init(endpoint: Endpoint, headers: HTTPHeaders? = nil) {

        if let headers = headers {
            self.headers = headers
        }

        self.endpoint = endpoint
    }

    func request<T: Decodable>(info: Any,
                               success: @escaping (T) -> Void,
                               failure: @escaping () -> Void) {

        process(info: info)
    }

    func request<T: Decodable>(info: Any,
                               success: @escaping ([T]) -> Void,
                               failure: @escaping () -> Void) {

        process(info: info)
    }

    private func process(info: Any) {

        if let info = info as? Parameters {
            self.parameters = info
        }
    }
}
