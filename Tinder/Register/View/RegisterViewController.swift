//
//  RegisterViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/21.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

final class RegisterViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()

    // MARK: Views
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolderText: "名前")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")
    private let registerButton = RegisterButton(text: "登録")
    private let loginButton = UIButton(type: .system).loginButton(text: "アカウントをお持ちの方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()

        // 画面のグラデーション
        setUpGradientLayer()
        setUpLayout()
        setUpBindins()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    private func setUpLayout() {
        passwordTextField.isSecureTextEntry = true

        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        // stackViewを横並びに
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20

        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)

        // ひとつの高さを決めると全部同じ高さになる
        nameTextField.anchor(height: 45)
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

    private func setUpBindins() {
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextOutput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextOutput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                // 登録時の処理
                self?.createUser()
            }
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                // ログイン画面に遷移
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)

        viewModel.validRegisterDriver
            .drive { validAll in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78): .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)

    }

    private func createUser() {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        HUD.show(.progress)
        Auth.createUserFireAuth(name: name, email: email, password: password) { success in
            HUD.hide()
            if success {
                print("会員登録の処理が完了")
                self.dismiss(animated: true)
            } else {

            }
        }
    }

}
