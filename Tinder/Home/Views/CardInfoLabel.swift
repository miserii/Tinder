//
//  CardInfoLabel.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/08.
//

import UIKit

final class CardInfoLabel: UILabel {

    init(text: String, labelColor: UIColor) {
        super.init(frame: .zero)

        font = .boldSystemFont(ofSize: 45)
        self.text = text
        self.textColor = labelColor
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        textAlignment = .center
        alpha = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // その他のtextColorが白のLabel
    init(text: String, labelFont: UIFont) {
        super.init(frame: .zero)

        font = labelFont
        self.textColor = .white
        self.text = text
    }

}
