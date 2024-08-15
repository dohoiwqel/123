//
//  FavouritesManager.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 15.08.2024.
//

import Foundation

class FavoritesManager {
    
    //MARK: Properties
    static let shared = FavoritesManager()
    
    private init() {}
    
    private let favoritesKeyPrefix = "favorites_"
    
    // Получает текущего пользователя из AuthManager
    private func getCurrentUsername() -> String? {
        return AuthManager.shared.getCurrentUserName()
    }
    
    // Получает ключ для хранения избранных треков конкретного пользователя
    private func getFavoritesKey() -> String? {
        guard let username = getCurrentUsername() else { return nil }
        return "\(favoritesKeyPrefix)\(username)"
    }
    
    // Сохраняет идентификаторы избранных треков в UserDefaults
    func saveFavoriteTrack(id: UUID) {
        guard let key = getFavoritesKey() else { return }
        var favoriteIDs = fetchFavoriteTrackIDs()
        if !favoriteIDs.contains(id) {
            favoriteIDs.append(id)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(favoriteIDs), forKey: key)
        }
    }
    
    // Удаляет идентификатор трека из избранного
    func removeFavoriteTrack(id: UUID) {
        guard let key = getFavoritesKey() else { return }
        var favoriteIDs = fetchFavoriteTrackIDs()
        if let index = favoriteIDs.firstIndex(of: id) {
            favoriteIDs.remove(at: index)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(favoriteIDs), forKey: key)
        }
    }
    
    // Проверяет, является ли трек избранным
    func isFavoriteTrack(id: UUID) -> Bool {
        return fetchFavoriteTrackIDs().contains(id)
    }
    
    // Загружает все идентификаторы избранных треков
    private func fetchFavoriteTrackIDs() -> [UUID] {
        guard let key = getFavoritesKey() else { return [] }
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            return (try? PropertyListDecoder().decode([UUID].self, from: data)) ?? []
        }
        return []
    }
    
    // Возвращает все идентификаторы избранных треков
    func getAllFavoriteTrackIDs() -> [UUID] {
        return fetchFavoriteTrackIDs()
    }
}
