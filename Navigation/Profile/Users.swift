//
//  Users.swift
//  Navigation
//
//  Created by Illya Blinov on 7.06.23.
//

import Foundation

struct Users {
    let login: String
    var password: String
    static func craeteUser(login: String, password: String) -> Users {
        return Users(login: login, password: password)
    }
}
