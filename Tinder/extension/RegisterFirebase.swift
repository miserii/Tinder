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

    static func loginFireAuth(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログインに失敗: ", err)
                completion(false)
                return
            }
            print("ログインに成功")
            completion(true)
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

    // Firestoreからユーザー情報を取得
    static func getUserFireStore(uid: String, compeltion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapShot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                compeltion(nil)
                return
            }

            guard let data = snapShot?.data() else { return }
            let user = User(dic: data)
            compeltion(user)
        }
    }

    // Firestoreから自分以外のユーザー情報を取得
    static func fetchUsersFirestore(compeltion: @escaping ([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments { (snapShots, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                return
            }
            /*
            var users = [User]()
            snapShots?.documents.forEach({ (snapShot) in

                let data = snapShot.data()
                let user = User(dic: data)
                users.append(user)
            })
            */
            let users = snapShots?.documents.map({ (snapShot) -> User in
                // mapがドキュメントそれぞれに処理を行い、新しい値を戻してる
                let data = snapShot.data()
                let user = User(dic: data)
                return user
            })

            compeltion(users ?? [User]())
        }
    }

}
