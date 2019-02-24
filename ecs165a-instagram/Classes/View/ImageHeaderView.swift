//
//  ImageHeaderView.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit

class ImageHeaderView: IGBaseView {

    private let picture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()

    private let uploadButton: UIButton = {

        let button = UIButton()
        button.backgroundColor = .themeBlue
        button.layer.cornerRadius = 10
        button.setTitle("Upload Image", for: .normal)
        return button
    }()

    func config(image: UIImage?) {
        picture.image = image
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func addTarget(target: Any, selector: Selector) {

        let tapGesture = UITapGestureRecognizer(target: target, action: selector)

        uploadButton.addTarget(target, action: selector, for: .touchUpInside)
        addGestureRecognizer(tapGesture)
    }

    private func setup() {

        addMultipleSubviews(views: [uploadButton, picture])

        uploadButton.snp.makeConstraints { maker in

            maker.center.equalToSuperview()
            maker.height.equalTo(40)
            maker.leading.equalToSuperview().offset(40)
        }

        picture.snp.makeConstraints { maker in

            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
        }
    }
}
