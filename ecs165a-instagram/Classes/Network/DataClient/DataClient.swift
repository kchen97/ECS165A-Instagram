//
//  DataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

protocol DataClient {

    func request<T: Mappable>(info: Any?,
                              success: @escaping (T?) -> Void,
                              failure: @escaping (ServiceResponse) -> Void)

    func request<T: Mappable>(info: Any?,
                              success: @escaping ([T]?) -> Void,
                              failure: @escaping (ServiceResponse) -> Void)

    func request(info: Any?,
                 success: @escaping () -> Void,
                 failure: @escaping (ServiceResponse) -> Void)

    func upload(info: Any?,
                success: @escaping () -> Void,
                failure: @escaping (ServiceResponse) -> Void)

    func download(info: Any?,
                  success: @escaping (UIImage?) -> Void,
                  failure: @escaping () -> Void)

    func process(info: Any?)
}
