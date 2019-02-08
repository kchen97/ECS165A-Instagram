//
//  InputViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/5/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

enum InputType: String {
    case text = "textFieldCellId"
    case button = "buttonCellId"
}

typealias InputField = (title: String, type: InputType)

@objcMembers class InputViewModel: IGBaseViewModel {

    var fields: [InputField]!

    init(fields: [InputField] = []) {
        self.fields = fields
    }
}
