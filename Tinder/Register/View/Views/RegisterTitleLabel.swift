//
//  RegisterTitleLabel.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/21.
//

import UIKit

final class RegisterTitleLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)

        self.text = text
        self.font = .boldSystemFont(ofSize: 80)
        self.textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
