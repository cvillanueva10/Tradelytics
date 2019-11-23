//
//  SessionStore.swift
//  Tradelytics
//
//  Created by Bhris on 11/22/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
import FirebaseAuth

class SessionStore : ObservableObject {
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func getUserId() -> String? {
        return session?.uid
    }

    func listen(sessionFound: @escaping () -> Void) {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
                sessionFound()
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
}
