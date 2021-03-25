//
//  ViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/02/18.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let navi = UINavigationController(rootViewController: registerViewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }
    }

    private func setUpLayout() {
        view.backgroundColor = .white

        let topView = TopView()
        let cardView = CardView()
        let bottomView = BottomView()

        let stackView = UIStackView(arrangedSubviews: [topView, cardView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)

        [
            topView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        .forEach { $0.isActive = true }

        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tapLogout), for: .touchUpInside)
    }

    @objc private func tapLogout() {
        do {
            try Auth.auth().signOut()
            let registerViewController = RegisterViewController()
            let navi = UINavigationController(rootViewController: registerViewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        } catch {
            print("ログアウトに失敗: ", error)
        }
    }

}
