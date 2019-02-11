//
//  NetworkDataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Alamofire
import ObjectMapper
import FirebaseDatabase

class NetworkDataClient: DataClient {

    private var pathTemplate: String!
    private var endpoint: Endpoint!
    private var headers: HTTPHeaders?
    private var parameters: Parameters?

    init(endpoint: Endpoint, headers: HTTPHeaders? = nil) {

        if let headers = headers {
            self.headers = headers
        }

        self.endpoint = endpoint
        self.pathTemplate = endpoint.path
    }

    func request<T: Mappable>(info: Any,
                              success: @escaping (T?) -> Void,
                              failure: @escaping () -> Void) {
        process(info: info)

        getDataRequest().validate().responseJSON { response in

            switch response.result {

            case .success:
                success(self.parse(data: response.result.value))

            case .failure:
                failure()

            }
        }
    }

    func request<T: Mappable>(info: Any,
                              success: @escaping ([T]?) -> Void,
                              failure: @escaping () -> Void) {

        process(info: info)

        getDataRequest().validate().responseJSON { response in

            switch response.result {

            case .success:
                success(self.parseArray(data: response.result.value))

            case .failure:
                failure()

            }
        }
    }

    func process(info: Any) {

        if let info = info as? Parameters {
            parameters = info;
        }
    }

    private func getDataRequest() -> DataRequest {

        return Alamofire.request(endpoint.path,
                                 method: endpoint.method,
                                 parameters: parameters,
                                 encoding: endpoint.encoding,
                                 headers: headers)
    }

    private func parse<T: Mappable>(data: Any?) -> T? {

        if let data = data as? [String: Any] {
            return T(JSON: data)
        }

        return nil
    }

    private func parseArray<T: Mappable>(data: Any?) -> [T]? {

        if let data = data as? [[String: Any]] {
            return Mapper<T>().mapArray(JSONArray: data)
        }

        return nil
    }
}
