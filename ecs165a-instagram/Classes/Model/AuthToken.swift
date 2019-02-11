//
//  AuthToken.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class AuthToken: IGBaseModel {

    var token: String!

    override func mapping(map: Map) {

        super.mapping(map: map)

        token <- map["token"]
    }
}
