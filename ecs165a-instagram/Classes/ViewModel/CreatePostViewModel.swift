//
//  CreatePostViewModel.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CreatePostViewModel: IGBaseViewModel {

    let CAPTION_ROW = 0
    let TAG_ROW = 1

    private lazy var post = Post(JSON: [:])

    func set(text: String, row: Int) {

        switch row {

        case CAPTION_ROW:
            post?.caption = text

        case TAG_ROW:
            createTags(text: text)

        default:
            break

        }
    }

    func createPost(image: UIImage?, completion: @escaping (ServiceResponse) -> Void) {

        if let post = post, let data = image?.jpegData(compressionQuality: 0.2) {

            post.username = UserInfo.shared.username
            post.date = FormatterUtility().toString(date: Date())

            CreatePostViewService().createPost(post: post, data: data) { serviceResponse in
                completion(serviceResponse)
            }
        }
        else {
            completion(ServiceResponse.getInvalidRequestServiceResponse())
        }
    }

    private func createTags(text: String) {
        post?.tags = text.split(separator: " ").map { String($0) }
    }
}
