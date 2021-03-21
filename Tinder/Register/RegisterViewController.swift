//
//  RegisterViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/21.
//

import UIKit

class RegisterViewController: UIViewController {

    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolderText: "名前")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")

    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = .yellow

        setUpLayout()
    }

    private func setUpLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        // stackViewを横並びに
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)

        view.addSubview(titleLabel)

        // ひとつの高さを決めると全部同じ高さになる
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }

    private func setUpGradient() {
        
    }

}
