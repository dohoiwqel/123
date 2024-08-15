//
//  AuthViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 12.08.2024.
//

import Foundation

class AuthViewModel {
    
    private var userPassword = ""
    private var userName = ""
    
    private var verificationStatus = "failed"
    
    public func getVerificationStatus() -> String{
        verificationStatus
    }
    
    public func initiateUserData(name: String?, password: String?) {
        self.userName = name ?? ""
        self.userPassword = password ?? ""
    }
    
    public func logInUser() {
        print(self.userName, self.userPassword)
        if userName == "artem" && userPassword == "artem" {
            self.verificationStatus = "artem"
        } else if userName == "admin" && userPassword == "admin" {
            self.verificationStatus = "admin"
        } else {
            self.verificationStatus = "failed"
        }
        
    }
    
    public func verifyUser() {
        AuthManager.shared.login(username: self.userName, password: self.userName)
    }
}
