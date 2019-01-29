//
//  DataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

protocol DataClient {

    func request<T: Decodable>(info: Any,
                               success: @escaping (T) -> Void,
                               failure: @escaping () -> Void)

    func request<T: Decodable>(info: Any,
                               success: @escaping ([T]) -> Void,
                               failure: @escaping () -> Void)
}
