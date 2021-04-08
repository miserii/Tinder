//
//  ProfileTextField.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/07.
//

import UIKit

final class ProfileTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)

        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.backgroundColor = .rgb(red: 245, green: 245, blue: 245)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
