//
//  ViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/02/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerViewController = RegisterViewController()
            registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true)
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

        [
            topView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        .forEach { $0.isActive = true }
    }

}
