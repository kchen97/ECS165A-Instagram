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
    var views: Int?
    var likes : Int?
    var comments: Int?
    var datePosted: Date?

    override func mapping(map: Map) {
        super.mapping(map: map)

        username <- map["username"]
        caption <- map["caption"]
        views <- map["views"]
        likes <- map["likes"]
        comments <- map["comments"]

        if let stringDate = map["datePosted"].currentValue as? String {
            datePosted = FormatterUtility().toDate(date: stringDate)
        }
    }
}
