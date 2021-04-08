//
//  ProfileImageView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/06.
//

import UIKit

final class ProfileImageView: UIImageView {

    init() {
        super.init(frame: .zero)

        self.image = UIImage(named: "profile-unselect")
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 90
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
