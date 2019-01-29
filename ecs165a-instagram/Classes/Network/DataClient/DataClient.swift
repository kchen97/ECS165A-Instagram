//
//  DataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation
import ObjectMapper

protocol DataClient {

    func get<T: Mappable>(info: Any?,
                          success: @escaping (T?) -> Void,
                          failure: @escaping () -> Void)

    func post(info: Any?,
              success: @escaping () -> Void,
              failure: @escaping () -> Void)

    func patch(info: Any?,
               success: @escaping () -> Void,
               failure: @escaping () -> Void)

    func delete(info: Any?,
                success: @escaping () -> Void,
                failure: @escaping () -> Void)
}
