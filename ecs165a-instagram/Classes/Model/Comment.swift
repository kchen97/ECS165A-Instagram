//
//  Comment.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import ObjectMapper

class Comment: IGBaseModel {

    var comment: String?
    var username: String?
    var profilePicture: String?
    var picture: UIImage?
    var date: String?

    override func mapping(map: Map) {

        super.mapping(map: map)

        comment <- map["comment"]
        username <- map["username"]
        profilePicture <- map["profilePicture"]

        if let utcDate = FormatterUtility().toDate(date: map["date"].currentValue as? String ?? "") {

            date = FormatterUtility().toString(date: utcDate)
        }
    }
}
