//
//  ViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/02/18.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class HomeViewController: UIViewController {

    private var user: User?
    private var users = [User]()

    let topView = TopView()
    let cardView = UIView()
    let bottomView = BottomView()

    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Firestore.getUserFireStore(uid: uid) { (user) in
//            if let user = user {
//                self.user = user
//
//            }
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let navi = UINavigationController(rootViewController: registerViewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        }

        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.getUserFireStore(uid: uid) { (user) in
            if let user = user {
                self.user = user
            }
        }
        fetchUsers()

    }

    private func fetchUsers() {
        HUD.show(.progress)
        Firestore.fetchUsersFirestore { (users) in
            HUD.hide()
            self.users = users

            self.users.forEach { (user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            }
            print("ユーザー情報の取得に成功")
        }
    }

    private func setUpLayout() {
        view.backgroundColor = .white

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
