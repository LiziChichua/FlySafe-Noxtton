//
//  MenuOptions.swift
//  FlySafe
//
//  Created by LiziChichua on 08.01.22.
//

import Foundation

enum MenuOptionsForNewUser: String, CaseIterable {
    case newUser = "Hi, new user 🥰"
    case RegisterOrSignIn = "Register or Sign In"
}

enum MenuOptionsForRegisteredUser: String, CaseIterable {
   // case UserFullName = "User FullName"
   // case ChangePassword = "Change Password"
    case LogOut = "Log Out"
}
