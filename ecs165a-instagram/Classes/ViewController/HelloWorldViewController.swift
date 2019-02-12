//
//  HelloWorldViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 1/29/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

/*import UIKit
import SnapKit

class HelloWorldViewController: IGBaseViewController {

    private let helloWorldVM = HelloWorldViewModel()

    private let nameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(nameLabel)

        nameLabel.text = "......."
        nameLabel.textAlignment = .center

        nameLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        helloWorldVM.getPerson { [weak self] name in
            self?.nameLabel.text = "Hello \(name)"
        }
    }
}*/
