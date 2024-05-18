import Foundation
struct UserResult: Codable {
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
    let profileImage: ImageSizes
    
    struct ImageSizes: Codable {
        let small: String
        let medium: String
        let large: String
    }
}
