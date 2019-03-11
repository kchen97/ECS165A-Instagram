//
//  PlainTextFieldView.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class PlainTextFieldView: IGBaseView {

    var shouldReturn: ((String?) -> Void)?

    private let textField: PlainTextField = {

        let view = PlainTextField()
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 14.0)
        return view
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(placeholder: String?) {

        textField.placeholder = placeholder
    }

    private func setup() {

        backgroundColor = .themeLightGray
        textField.delegate = self

        addSubview(textField)

        textField.snp.makeConstraints { maker in

            maker.top.equalToSuperview().offset(1)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-1)
        }
    }
}

extension PlainTextFieldView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        shouldReturn?(textField.text)

        textField.resignFirstResponder()
        return true
    }
}
