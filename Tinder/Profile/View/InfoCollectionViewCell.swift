//
//  InfoCollectionViewCell.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/07.
//

import UIKit

final class InfoCollectionViewCell: UICollectionViewCell {

    var user: User? {
        // userに値がセットされたときに呼ばれる
        didSet {
            nameTextField.text = user?.name
            emailTextField.text = user?.email
        }
    }

    let nameLabel = ProfileLabel(title: "名前")
    let nameTextField = ProfileTextField(placeholder: "名前")
    let ageLabel = ProfileLabel(title: "年齢")
    let ageTextField = ProfileTextField(placeholder: "年齢")
    let emailLabel = ProfileLabel(title: "メールアドレス")
    let emailTextField = ProfileTextField(placeholder: "メールアドレス")
    let residenceLabel = ProfileLabel(title: "居住地")
    let residenceTextField = ProfileTextField(placeholder: "居住地")
    let hobbyLabel = ProfileLabel(title: "趣味")
    let hobbyTextField = ProfileTextField(placeholder: "趣味")
    let introductionLabel = ProfileLabel(title: "自己紹介")
    let introductionTextField = ProfileTextField(placeholder: "自己紹介")

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let views = [[nameLabel, nameTextField], [ageLabel, ageTextField], [emailLabel, emailTextField], [residenceLabel, residenceTextField], [hobbyLabel, hobbyTextField], [introductionLabel, introductionTextField]]

        let stackViews = views.map { (views) -> UIStackView in
            // labelとtextを取り出す。first→配列の最初、last→配列の最後
            guard let label = views.first as? UILabel,
                  let textField = views.last as? UITextField
            // 値がちゃんと取得できなかったらUIStackViewを返す
            else { return UIStackView() }

            let stackView = UIStackView(arrangedSubviews: [label, textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height: 50)

            return stackView
        }

        let baseStackView = UIStackView(arrangedSubviews: stackViews)
        baseStackView.axis = .vertical
        baseStackView.spacing = 15
        addSubview(baseStackView)

        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height: 80)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, leftPadding: 20, rightPadding: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
