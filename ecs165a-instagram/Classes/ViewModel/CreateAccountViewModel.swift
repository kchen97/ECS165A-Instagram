//
//  CreateAccountViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class CreateAccountViewModel: IGBaseViewModel {

    func validate(email: String?) -> Bool {

        let text = email ?? ""
        return text.contains("@") && text.contains(".") && text.count > 4
    }

    func validate(password: String?) -> Bool {

        let text = password ?? ""
        return text.count > 7
    }
}
