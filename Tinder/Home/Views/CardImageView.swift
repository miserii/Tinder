//
//  CardImageView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/12.
//

import UIKit

final class CardImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        // backgroundColor = .blue
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named: "bllie")
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
