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

typealias DatabaseResponse = (reference: DatabaseReference, error: Error?)

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

    func get<T: Mappable>(info: Any?,
                          success: @escaping (T?) -> Void,
                          failure: @escaping () -> Void) {

        process(info: info)

        Database.database().reference().child(pathTemplate).observeSingleEvent(of: .value, with: { snapshot in
            success(self.parse(data: snapshot.value))

        }) { error in

            debugPrint(error)
            failure()
        }
    }

    func post(info: Any?,
              success: @escaping () -> Void,
              failure: @escaping () -> Void) {

        process(info: info)

        Database.database().reference().child(pathTemplate).setValue(parameters) { error, _ in

            if let error = error {

                debugPrint(error)
                failure()
            }
            else {
                success()
            }
        }
    }

    func patch(info: Any?,
               success: @escaping () -> Void,
               failure: @escaping () -> Void) {

        process(info: info)

        Database.database().reference().child(pathTemplate).setValue(parameters) { error, _ in

            if let error = error {

                debugPrint(error)
                failure()
            }
            else {
                success()
            }
        }
    }

    func delete(info: Any?,
                success: @escaping () -> Void,
                failure: @escaping () -> Void) {

        process(info: info)

        Database.database().reference().child(pathTemplate).removeValue { error, _ in

            if let error = error {

                debugPrint(error)
                failure()
            }
            else {
                success()
            }
        }
    }

    private func process(info: Any?) {

        guard let info = info as? [String: Any] else { return }

        if let params = info[kParameterKey] as? Parameters {
            parameters = params
        }

        if let pathValues = info[kPathManipulationKey] as? [String: String] {

            for value in pathValues {
                pathTemplate = pathTemplate.replacingOccurrences(of: "{\(value.key)}", with: value.value)
            }
        }
    }

    private func parse<T: Mappable>(data: Any?) -> T? {

        if let data = data as? [String: Any] {
            return T(JSON: data)
        }

        return nil
    }
}
