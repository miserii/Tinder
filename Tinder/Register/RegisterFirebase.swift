//
//  RegisterFirebase.swift
//  Tinder
//
//  Created by OsakaMiseri on 2021/03/25.
//

import Firebase

// MARK: Auth
extension Auth {
    // Fireauthに保存
    // completionでエラーの時に返す
    static func createUserFireAuth(name: String?, email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email else { return }
        guard let passwoard = password else { return }

        Auth.auth().createUser(withEmail: email, password: passwoard) { (auth, err) in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            Firestore.setUserDataFirestore(name: name, email: email, uid: uid) { success in
                completion(success)
            }
        }
    }
}

// MARK: Firestore
extension Firestore {
    // Firestoreに保存
    static func setUserDataFirestore(name: String?, email: String, uid: String, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }

        let document = [
            "name" : name,
            "email" : email,
            "createAt" : Timestamp()
        ] as [String : Any]

        // ドキュメントidをuidにする
        Firestore.firestore().collection("users").document(uid).setData(document) { err in
            // errorがnilじゃない時はprint
            if let err = err {
                print("FireStoreへのユーザー情報の保存に失敗: ", err)
                return
            }
            completion(true)
            print("Firestoreへのユーザー情報の保存に成功: ")
        }
    }
}
