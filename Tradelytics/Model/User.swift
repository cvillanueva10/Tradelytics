//
//  User.swift
//  Tradelytics
//
//  Created by Bhris on 11/22/19.
//  Copyright © 2019 chrisrvillanueva. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
