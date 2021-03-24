//
//  LoginViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/25.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: Views
    private let titleLabel = RegisterTitleLabel(text: "Login")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")
    private let registerButton = RegisterButton(text: "ログイン")
    private let loginButton = UIButton(type: .system).loginButton(text: "アカウントをお持ちでない方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpGradientLayer()
        setUpLayout()
        setUpBinding()
    }

    private func setUpLayout() {
        passwordTextField.isSecureTextEntry = true

        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, registerButton])
        // stackViewを横並びに
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20

        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)

        // ひとつの高さを決めると全部同じ高さになる
        emailTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        loginButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }

    private func setUpGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor

        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setUpBinding() {
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

}
