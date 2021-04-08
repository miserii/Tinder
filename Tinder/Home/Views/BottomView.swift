//
//  ButtomView.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/02/25.
//

import UIKit

final class BottomView: UIView {

    let reloadView = BottomButtonView(frame: .zero, width: 50, imageName: "reload")
    let nopeView = BottomButtonView(frame: .zero, width: 60, imageName: "nope")
    let superLikeView = BottomButtonView(frame: .zero, width: 50, imageName: "superlike")
    let likeView = BottomButtonView(frame: .zero, width: 60, imageName: "like")
    let boostView = BottomButtonView(frame: .zero, width: 50, imageName: "boost")

    override init(frame: CGRect) {
        super.init(frame: frame)

        let baseStackView = UIStackView(arrangedSubviews: [reloadView, nopeView, superLikeView, likeView, boostView])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(baseStackView)
        baseStackView.anchor(top: topAnchor,
                             bottom: bottomAnchor,
                             left: leftAnchor, right:
                                rightAnchor, leftPadding: 10,
                             rightPadding: 10)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

final class BottomButtonView: UIView {

    var button: BottomButtonAnime?

    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)

        button = BottomButtonAnime(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: .init(width: width * 0.4, height: width * 0.4)), for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        addSubview(button!)
        button?.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: width, height: width)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// ボタンを押した際にサイズを縮小してアニメーションをつける
final class BottomButtonAnime: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                self.transform = .identity
                self.layoutIfNeeded()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
