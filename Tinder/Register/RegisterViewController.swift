//
//  RegisterViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/21.
//

import UIKit
import RxSwift

class RegisterViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: Views
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolderText: "名前")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")
    private let registerButton = RegisterButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 画面のグラデーション
        setUpGradientLayer()
        setUpLayout()
        setUpBindins()
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

    private func setUpGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor

        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setUpBindins() {
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textの情報ハンドル
            }
            .disposed(by: disposeBag)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in

            }
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in

            }
            .disposed(by: disposeBag)

        registerButton.rx.tap
            .asDriver()
            .drive { _ in
                // 登録時の処理
            }
            .disposed(by: disposeBag)

    }

    private func createUser() {

    }

}
