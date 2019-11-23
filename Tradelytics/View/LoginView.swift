//
//  LoginView.swift
//  Tradelytics
//
//  Created by Bhris on 11/22/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import SwiftUI

struct LoginView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore

    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email Address", text: $email)
            SecureField("Password", text: $password)
            if (error) {
                Text("ahhh crap")
            }
            Button(action: signIn) {
                Text("Sign in")
            }
        }.padding([.leading, .trailing], 16)
    }
}
