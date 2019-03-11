//
//  CommentTableViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/10/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CommentTableViewCell: IGBaseTableViewCell {

    private let picture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let commentLabel: UILabel = {

        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()

    private let dateLabel: UILabel = {

        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setup()
    }

    func config(username: String?, image: UIImage?, date: String?, comment: String?) {

        commentLabel.setAttributedText(text: (username ?? "") + " " + (comment ?? ""),
                                       attributedTexts: [(text: username ?? "",
                                                          font: UIFont.boldSystemFont(ofSize: 12.0)
                                        )])
        dateLabel.text = "Posted on \(date ?? "")"
    }

    private func setup() {

        contentView.addMultipleSubviews(views: [picture, commentLabel, dateLabel])

        commentLabel.snp.makeConstraints { maker in

            maker.top.equalToSuperview().offset(10)
            maker.leading.equalTo(picture.snp.trailing).offset(10)
            maker.trailing.equalToSuperview().inset(20)
            maker.bottom.equalTo(dateLabel.snp.top)
        }

        picture.snp.makeConstraints { maker in

            maker.top.equalTo(commentLabel.snp.top)
            maker.leading.equalTo(contentView.snp.leading).offset(10)
            maker.size.equalTo(CGSize(width: 30, height: 30))
        }

        dateLabel.snp.makeConstraints { maker in

            maker.bottom.equalToSuperview().offset(-20)
            maker.leading.equalTo(commentLabel.snp.leading)
            maker.trailing.equalTo(commentLabel.snp.trailing)
            maker.height.equalTo(12)
        }
    }
}
