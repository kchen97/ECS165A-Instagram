//
//  UserInfoViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/6/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import Foundation

class UserInfoViewModel: IGBaseViewModel {

    private var username: String?
    private var email: String?
    private var password: String?
    private var confirmPassword: String?
    private var firstName: String?
    private var lastName: String?

    func set(username: String?) {

        let text = (username ?? "")

        self.username = validate(username: username) ? text : nil
    }

    func set(email: String?) {

        self.email = validate(email: email) ? email : nil
    }

    func set(password: String?) {

        self.password = validate(password: password) ? password : nil
    }

    func set(confirmPassword: String?) {

        self.confirmPassword = confirmPassword
    }

    func set(firstName: String?) {

        let text = (firstName ?? "")

        self.firstName = text.isEmpty ? nil : text
    }

    func set(lastName: String?) {

        let text = (lastName ?? "")

        self.lastName = text.isEmpty ? nil : text
    }

    func validate(username: String?) -> Bool {

        let text = username ?? ""
        return text.count > 6
    }

    func validate(email: String?) -> Bool {

        let text = email ?? ""
        return text.contains("@") && text.contains(".") && text.count > 4
    }

    func validate(password: String?) -> Bool {

        let text = password ?? ""
        return text.count > 6
    }

    func loginEnabled() -> Bool {
        return email != nil && password != nil
    }

    func signUpEnabled() -> Bool {

        return email != nil
            && password != nil
            && confirmPassword == password
            && firstName != nil
            && lastName != nil
            && username != nil
    }

    func signUp(completion: @escaping (ServiceResponse) -> Void) {

        let user = User(JSON: [:])

        user?.firstName = firstName
        user?.lastName = lastName
        user?.username = username
        user?.email = email
        user?.password = password

        if let user = user {

            CredentialsViewService().signUp(user: user) { serviceResponse in
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }

    func login(completion: @escaping (ServiceResponse) -> Void) {

        let user = User(JSON: [:])

        user?.email = email
        user?.password = password

        if let user = user {

            CredentialsViewService().login(user: user) { serviceResponse in
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }
}
