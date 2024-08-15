//
//  AuthManager.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//


import Foundation
// Класс для работы с авторизацией
class AuthManager {
    // Статическое свойство для доступа к синглтону
    static let shared = AuthManager()
    
    
    // Приватные свойства для хранения информации о пользователе
    private let usernameKey = "username"
    private let passwordKey = "password"
    
    // Метод для проверки, авторизован ли пользователь
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: usernameKey) != nil
    }
    
    // Метод для авторизации пользователя
    func login(username: String, password: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
    }
    
    // Метод для выхода из учетной записи
    func logout() {
        UserDefaults.standard.removeObject(forKey: usernameKey)
        UserDefaults.standard.removeObject(forKey: passwordKey)
    }
    
    // Метод для получения имени пользователя после авторизации
    func getCurrentUserName() -> String? {
        return UserDefaults.standard.string(forKey: usernameKey)!
    }
    
    
}
