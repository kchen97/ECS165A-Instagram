//
//  User.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class User: IGBaseModel {

    var firstName: String?
    var lastName: String?
    var username: String?
    var email: String?
    var password: String?

    override func mapping(map: Map) {

        super.mapping(map: map)

        firstName <- map["firstName"]
        lastName <- map["lastName"]
        username <- map["username"]
        email <- map["email"]
        password <- map["password"]
    }
}

