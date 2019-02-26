//
//  PlainTextViewTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit
import SnapKit
import RSKGrowingTextView

class PlainTextViewTableViewCell: IGBaseTableViewCell {

    var textChanged: ((String) -> Void)?

    private let textView: RSKGrowingTextView = {

        let view = RSKGrowingTextView()
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.isEditable = true
        view.isScrollEnabled = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(placeholder: String) {
        textView.placeholder = placeholder as NSString
    }

    private func setup() {

        contentView.addSubview(textView)

        textView.delegate = self
        textView.snp.makeConstraints { maker in

            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().inset(20)
        }
    }
}

extension PlainTextViewTableViewCell: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
