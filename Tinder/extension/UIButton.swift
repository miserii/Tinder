//
//  UIButton.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/12.
//

import UIKit

extension UIButton {

    func createCardInfoButton() -> UIButton {
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit

        return self
    }

    func loginButton(text: String) -> UIButton {
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.setTitle(text, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)

        return self
    }

    func createProfileTopButton(title: String) -> UIButton {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 15)
        return self
    }

    func createProfileEditButton() -> UIButton {
        let image = UIImage(systemName: "square.and.pencil")
        self.setImage(image, for: .normal)
        self.layer.cornerRadius = 30
        self.tintColor = .darkGray
        self.imageView?.contentMode = .scaleToFill
        self.backgroundColor = .white
        return self
    }

}
