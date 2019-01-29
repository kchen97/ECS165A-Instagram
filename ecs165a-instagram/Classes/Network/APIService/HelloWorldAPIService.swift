//
//  HelloWorldAPIService.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class HelloWorldAPIService: IGBaseAPIService {

    func create(obj: HelloWorldModel) {

        APIStorage.storage.saveHelloWorldAPI?.post(info: [kParameterKey: obj.toJSON(), kPathManipulationKey: obj.toJSON()], success: {

            debugPrint("success")
        }, failure: {
            debugPrint("failed")
        })
    }

    func getPerson(name: String, completion: @escaping (HelloWorldModel?) -> Void) {

        APIStorage.storage.getHelloWorldAPI?.get(info: [kPathManipulationKey: ["name": name]], success: { (helloWorldModel: HelloWorldModel?) in

            debugPrint(helloWorldModel?.toJSON() ?? "Unexpected Result: Request succeeded but invalid response")

            completion(helloWorldModel)

        }, failure: {
            debugPrint("failed")
        })
    }
}
