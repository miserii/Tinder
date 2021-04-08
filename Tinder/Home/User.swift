//
//  User.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/04/02.
//

import Foundation
import Firebase

final class User {

    var email: String
    var name: String
    var createdAt: Timestamp

    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
