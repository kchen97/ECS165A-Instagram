//
//  Post.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class Post: IGBaseModel {

    var username: String?
    var caption: String?
    var tags: [String]?
    var likes : Int?
    var comments: Int?
    var date: String?
    var imageLink: String?

    override func mapping(map: Map) {
        super.mapping(map: map)

        username <- map["username"]
        caption <- map["caption"]
        tags <- map["tags"]
        likes <- map["numLikes"]
        comments <- map["numComments"]
        date <- map["date"]
        imageLink <- map["postPicture"]
    }
}
