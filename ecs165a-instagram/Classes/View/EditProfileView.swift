//
//  EditProfileButton.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/12/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class EditProfileView: IGBaseView {

    var pictureTapped: (() -> Void)?
    var saveTapped: ((UIImage?, String?) -> Void)?

    private let picture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.themeBlue.cgColor
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()

    private let bioTextField: PlainTextField = {

        let view = PlainTextField()
        view.placeholder = "Enter new biography..."
        return view
    }()

    private let saveButton: UIButton = {

        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .themeBlue
        return button
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(image: UIImage?) {

        picture.image = image
    }

    @objc private func imageTapped() {

        pictureTapped?()
    }

    @objc private func savePressed() {

        saveTapped?(picture.image, bioTextField.text)
    }

    private func setup() {

        addMultipleSubviews(views: [picture, bioTextField, saveButton])

        bioTextField.delegate = self

        picture.snp.makeConstraints { maker in

            maker.top.equalToSuperview().offset(10)
            maker.centerX.equalToSuperview()
            maker.size.equalTo(CGSize(width: 100, height: 100))
        }

        bioTextField.snp.makeConstraints { maker in

            maker.top.equalTo(picture.snp.bottom).offset(10)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(50)
        }

        saveButton.snp.makeConstraints { maker in

            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.top.equalTo(bioTextField.snp.bottom)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        picture.addGestureRecognizer(tapGesture)

        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
    }
}

extension EditProfileView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
