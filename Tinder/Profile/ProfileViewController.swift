//
//  ProfileViewController.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/05.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?

    private let cellId = "cellId"

    let saveButton = UIButton(type: .system).createProfileTopButton(title: "保存")
    let logOutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let editButton = UIButton(type: .system).createProfileEditButton()
    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
    }

    private func setUpLayout() {
        view.backgroundColor = .white
        nameLabel.text = user?.name

        view.addSubview(saveButton)
        view.addSubview(logOutButton)
        view.addSubview(nameLabel)
        view.addSubview(profileImageView)
        view.addSubview(editButton)
        view.addSubview(infoCollectionView)

        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20, leftPadding: 15)
        logOutButton.anchor(top: view.topAnchor, right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        editButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user

        return cell
    }

}
