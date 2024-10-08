import Foundation
import WebKit


final class ProfileLogoutService {
    
    static let shared = ProfileLogoutService()
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    
    private init() { }
    
    func logout() {
        cleanCookies()
    }
    
    private func cleanCookies() {
        oAuth2TokenStorage.resetToken()
        profileService.profileModel = nil
        profileImageService.profileImageURL = nil
        imagesListService.cleanPhotos()
        HTTPCookieStorage.shared.cookies?.forEach(HTTPCookieStorage.shared.deleteCookie)
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date(timeIntervalSince1970: 0), completionHandler: {})
    }
}
