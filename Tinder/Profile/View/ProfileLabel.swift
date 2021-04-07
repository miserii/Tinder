//
//  ProfileLabel.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/06.
//

import UIKit

class ProfileLabel: UILabel {

    init() {
        super.init(frame: .zero)

        self.font = .systemFont(ofSize: 45, weight: .bold)
        self.textColor = .black
    }

    init(title: String) {
        super.init(frame: .zero)

        self.text = title
        self.font = .systemFont(ofSize: 14)
        self.textColor = .darkGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
