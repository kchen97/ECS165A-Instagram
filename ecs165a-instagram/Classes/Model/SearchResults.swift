//
//  SearchResults.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class SearchResults: IGBaseModel {

    var users: [User]?
    var posts: [Post]?

    override func mapping(map: Map) {

        super.mapping(map: map)

        users <- map["users"]
        posts <- map["posts"]
    }
}
