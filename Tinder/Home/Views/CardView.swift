//
//  CardView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/08.
//

import UIKit

final class CardView: UIView {

    private let gradientLayer = CAGradientLayer()

    // MARK: UIView
    private let cardImageView = CardImageView(frame: .zero)
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let nameLabel = CardInfoLabel(text: "名前 19", labelFont: .systemFont(ofSize: 40, weight: .heavy))
    private let residenceLabel = CardInfoLabel(text: "東京", labelFont: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(text: "趣味", labelFont: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(text: "よろしくお願いします", labelFont: .systemFont(ofSize: 25, weight: .regular))
    private let goodLabel = CardInfoLabel(text: "LIKE", labelColor: .rgb(red: 137, green: 223, blue: 86))
    private let nopeLabel = CardInfoLabel(text: "NOPE", labelColor: .rgb(red: 222, green: 110, blue: 110))

    init(user: User) {
        super.init(frame: .zero)

        setUpLayout(user: user)
        setUpGradientLayer()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }

    // Viewのグラデーション
    private func setUpGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }

    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else { return }

        if gesture.state == .changed {
            self.panChange(translation: translation)

        } else if gesture.state == .ended {
            self.panEnded(view: view, translation: translation)
        }

    }

    // スワイプの際のアニメーション
    private func panChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100

        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)

        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x

        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
    }

    private func panEnded(view: UIView, translation: CGPoint) {
        // print("translation.x: ", translation.x)

        if translation.x <= -120 {
            view.removeCardAnimation(x: -600)

        } else if translation.x >= 120 {
            view.removeCardAnimation(x: 600)

        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {

                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }

    }

    private func setUpLayout(user: User) {
        let infoStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoStackView.axis = .vertical

        let baseStackView = UIStackView(arrangedSubviews: [infoStackView, infoButton])
        baseStackView.axis = .horizontal

        // Viewのレイアウト
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)

        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left:  cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)

        // ユーザー情報をViewに反映
        nameLabel.text = user.name
        introductionLabel.text = user.email
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
