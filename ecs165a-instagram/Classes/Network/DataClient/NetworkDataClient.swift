//
//  NetworkDataClient.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/24/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Alamofire
import ObjectMapper

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

    func request(info: Any, success: @escaping () -> Void, failure: @escaping () -> Void) {

        process(info: info)

        getDataRequest().validate().responseJSON { response in

            switch response.result {

            case .success:
                success()

            case .failure:
                failure()
            }
        }
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

    func upload(info: Any, success: @escaping () -> Void, failure: @escaping () -> Void) {

        process(info: info)

        Alamofire.upload(multipartFormData: { multipartFormData in

            if let parameters = self.parameters {

                for (key, val) in parameters {

                    if let data = val as? Data {
                        multipartFormData.append(data, withName: key, fileName: UUID().uuidString + ".jpg", mimeType: "image/jpg")
                    }
                    else {
                        multipartFormData.append("\(val)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
            }
        },
        usingThreshold: UInt64.init(),
        to: endpoint.path,
        method: endpoint.method,
        headers: headers) { encodingResult in

            switch encodingResult {

            case .success(let upload, _, _):

                upload.validate().responseJSON { response in

                    switch response.result {

                    case .success:
                        success()
                    case .failure:
                        failure()
                    }
                }

            case .failure:

                failure()
            }
        }
    }

    func process(info: Any) {

        if let info = info as? Parameters {
            parameters = info
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
