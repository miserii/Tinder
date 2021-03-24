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
        passwordTextField.isSecureTextEntry = true

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
            .drive { [weak self] _ in
                // 登録時の処理
                self?.createUserFireAuth()

            }
            .disposed(by: disposeBag)

    }

    // Fireauthに保存
    private func createUserFireAuth() {
        guard let email = emailTextField.text else { return }
        guard let passwoard = passwordTextField.text else { return }

        Auth.auth().createUser(withEmail: email, password: passwoard) { (auth, err) in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            self.setUserDataFirestore(email: email, uid: uid)
        }
    }

    // Firestoreに保存
    private func setUserDataFirestore(email: String, uid: String) {
        guard let name = nameTextField.text else { return }

        let document = [
            "name" : name,
            "email" : email,
            "createAt" : Timestamp()
        ] as [String : Any]

        // ドキュメントidをuidにする
        Firestore.firestore().collection("users").document(uid).setData(document) { err in
            // errorがnilじゃない時はprint
            if let err = err {
                print("FireStoreへのユーザー情報の保存に失敗: ", err)
                return
            }
            print("Firestoreへのユーザー情報の保存に成功: ")
        }
    }

}
