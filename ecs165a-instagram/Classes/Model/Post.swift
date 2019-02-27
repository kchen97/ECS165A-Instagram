//
//  Post.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper
import UIKit

class Post: IGBaseModel {

    var postID: String?
    var username: String?
    var caption: String?
    var tags: [String]?
    var likes : Int?
    var comments: Int?
    var date: String?
    var imageLink: String?
    var image: UIImage?

    override func mapping(map: Map) {
        super.mapping(map: map)

        postID <- map["postID"]
        username <- map["username"]
        caption <- map["caption"]
        tags <- map["tags"]
        likes <- map["numLikes"]
        comments <- map["numComments"]
        imageLink <- map["postPicture"]

        if let utcDate = FormatterUtility().toDate(date: map["date"].currentValue as? String ?? "") {

            date = FormatterUtility().toString(date: utcDate)
        }
    }
}
