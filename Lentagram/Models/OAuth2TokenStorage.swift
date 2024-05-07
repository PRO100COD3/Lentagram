//
//  OAuth2TokenStorage.swift
//  Lentagram
//
//  Created by Вадим Дзюба on 07.05.2024.
//

import UIKit
protocol OAuth2TokenStorageProtocol {
    var token: String? { get set }
}

final class OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    
    private enum Keys: String {
        case token
    }
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
            get {
                return UserDefaults.standard.string(forKey: Keys.token.rawValue)
            }
            set {
                UserDefaults.standard.set(newValue, forKey: Keys.token.rawValue)
            }
    }
}
