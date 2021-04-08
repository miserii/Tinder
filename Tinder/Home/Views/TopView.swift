//
//  TopView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/04.
//

import UIKit
import RxSwift
import RxCocoa

final class TopView: UIView {

    private let disposeBag = DisposeBag()

    let tinderButton = createTopButton(imageName: "tinder-select", unselectedImage: "tinder-unselect")
    let goodButton = createTopButton(imageName: "good-select", unselectedImage: "good-unselect")
    let commentButton = createTopButton(imageName: "comment-select", unselectedImage: "comment-unselect")
    let profileButton = createTopButton(imageName: "profile-select", unselectedImage: "profile-unselect")

    static private func createTopButton(imageName: String, unselectedImage: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpLayout()
        setUpBindings()
    }

    private func setUpLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 45
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(baseStackView)
        baseStackView.anchor(top: topAnchor,
                             bottom: bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             leftPadding: 40,
                             rightPadding: 40)
//        [
//            baseStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            baseStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
//            baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
//        ]
//        .forEach { $0.isActive = true }

        tinderButton.isSelected = true
    }

    // トップのボタンをタップした時にimageを切り替える
    private func setUpBindings() {
        tinderButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedButton(selectButton: self.tinderButton)
            })
            .disposed(by: disposeBag)

        goodButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedButton(selectButton: self.goodButton)
            })
            .disposed(by: disposeBag)

        commentButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedButton(selectButton: self.commentButton)
            })
            .disposed(by: disposeBag)

        profileButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.selectedButton(selectButton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }

    private func selectedButton(selectButton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]

        buttons.forEach { button in
            if button == selectButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
