//
//  HelloWorldViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class HelloWorldViewModel: IGBaseViewModel {

    func createHelloWorld(name: String = "Korman") {

        if let model = HelloWorldModel(JSON: ["name": name]) {
            HelloWorldAPIService().create(obj: model)
        }
    }

    func getPerson(name: String = "Korman", completion: @escaping (String) -> Void) {

        HelloWorldAPIService().getPerson(name: name) { person in

            completion(person?.name ?? "Error")
        }
    }
}
