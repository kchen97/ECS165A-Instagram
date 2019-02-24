//
//  FormatterUtility.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

let kDefaultDateFormat = "MM/dd/yyyy"

class FormatterUtility {

    func toDate(date: String, format: String = kDefaultDateFormat) -> Date? {

        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = format

        return formatter.date(from: date)
    }

    func toString(date: Date, format: String = kDefaultDateFormat) -> String {

        let formatter = DateFormatter()
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}
