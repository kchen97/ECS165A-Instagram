//
//  PostCollectionViewCell.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 3/11/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    private let picture: UIImageView = {

        let view = UIImageView()
        view.contentMode = .scaleToFill
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

    func config(image: UIImage?) {

        picture.image = image
    }

    private func setup() {

        contentView.addSubview(picture)

        picture.snp.makeConstraints { maker in

            maker.edges.equalToSuperview()
        }
    }
}
