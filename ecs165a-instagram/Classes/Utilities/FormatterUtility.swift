//
//  FormatterUtility.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

let kDefaultDateFormat = "MM/dd/yyyy"
let kDetailedDateFormat = "MMM d, yyyy, h:mm a"
private let kUTCDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

class FormatterUtility {

    /// Default to UTC
    func toDate(date: String, format: String = kUTCDateFormat) -> Date? {

        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = format

        return formatter.date(from: date)
    }

    /// Default to MMM d, yyyy, h:mm a
    func toString(date: Date, format: String = kDetailedDateFormat) -> String {

        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}
