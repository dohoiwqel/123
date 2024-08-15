//
//  ProfileViewModel.swift
//  BistrovPBD
//
//  Created by Александр Андреев on 16.08.2024.
//

import Foundation

class ProfileViewModel {
    
    private let authManager = AuthManager.shared
    
    public func getText() -> String {
        var text = ""
        if authManager.getCurrentUserName() != "admin" {
            text = " 1. Возможность просмотра ленты с треками. \n 2. Возможность добавлять треки в избранное.\n 3. Возможность удалять треки из избранного.\n 4. Возможность использовать плеер."
        } else {
            text = " 1. Возможность просмотра ленты с треками. \n 2. Возможность добавлять треки в избранное.\n 3. Возможность удалять треки из избранного.\n 4. Возможность использовать плеер \n 5. Возможность добавлять треки.\n 6. Возможность удалять треки."
        }
        return text
    }
    
    public func getAvatarName() -> String {
        var avatarName = ""
        if authManager.getCurrentUserName() == "admin" {
            avatarName = Resources.Images.Avatar.adminAvatar
        } else {
            avatarName = Resources.Images.Avatar.userAvatar
        }
        return avatarName
    }
    
    public func getUsername() -> String {
        return authManager.getCurrentUserName()!
    }
}
