//
//  OAuth2Service.swift
//  Lentagram
//
//  Created by Вадим Дзюба on 07.05.2024.
//

import UIKit
final class OAuth2Service {
    static let shared = OAuth2Service()
    func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com")
        else{
            return nil
        }
        guard let url = URL(
            string: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"         // Используем знак ?, чтобы начать перечисление параметров запроса
            + "&&client_secret=\(Constants.secretKey)"    // Используем &&, чтобы добавить дополнительные параметры
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            relativeTo: baseURL                           // Опираемся на основной или базовый URL, которые содержат схему и имя хоста
        ) else{
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    func fetchOAuthToken(for code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let requestWithCode = makeOAuthTokenRequest(code: code) else { return }
            
            let task = URLSession.shared.data(for: requestWithCode){ result in
                switch result {
                case .success(let data):
                    do {
                        let oAuthToken = try JSONDecoder().decode(OAuthTokenResponseBody.self, from:data)
                        guard let accessToken = oAuthToken.accessToken else {
                            fatalError("Can`t decode token!")
                        }
                        completion(.success(accessToken))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
}
