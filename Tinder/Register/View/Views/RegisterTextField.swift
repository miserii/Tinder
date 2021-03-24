//
//  RegisterTextField.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/21.
//

import UIKit

class RegisterTextField: UITextField {

    init(placeHolderText: String) {
        super.init(frame: .zero)

        placeholder = placeHolderText
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
