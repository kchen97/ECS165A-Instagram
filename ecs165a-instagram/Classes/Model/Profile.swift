//
//  Profile.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class Profile: IGBaseModel {

    var firstName: String?
    var lastName: String?
    var username: String?
    var biography: String?
    var posts: Int?
    var followers: Int?
    var following: Int?

    override func mapping(map: Map) {

        super.mapping(map: map)

        firstName <- map["firstName"]
        lastName <- map["lastName"]
        username <- map["username"]
        biography <- map["bio"]
        posts <- map["numPosts"]
        followers <- map["numFollowers"]
        following <- map["numFollowing"]
    }
}
