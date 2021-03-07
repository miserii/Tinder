//
//  CardView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/08.
//

import UIKit

class CardView: UIView {

    let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "bllie")
        iv.clipsToBounds = true
        
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "name age"

        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }()

    let residenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "address"

        return label
    }()

    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "hobby"

        return label
    }()

    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "one word"

        return label
    }()

    let goodLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.text = "GOOD"
        label.textColor = .rgb(red: 137, green: 223, blue: 86)
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 137, green: 223, blue: 86).cgColor
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.alpha = 0

        return label
    }()

    let nopeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.text = "NOPE"
        label.textColor = .rgb(red: 222, green: 110, blue: 110)
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.alpha = 0

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpLayout()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }

    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        if gesture.state == .changed {
            self.panChange(translation: translation)

        } else if gesture.state == .ended {
                self.panEnded()
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

    private func panEnded() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {

            self.transform = .identity
            self.layoutIfNeeded()
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
        }

    }

    private func setUpLayout() {
        let infoStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoStackView.axis = .vertical

        let baseStackView = UIStackView(arrangedSubviews: [infoStackView, infoButton])
        baseStackView.axis = .horizontal

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
