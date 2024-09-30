import Lentagram
import UIKit

final class ProfileViewControllerMock: ProfileViewControllerProtocol {
    let imageView = UIImageView()
    let exitButton = UIButton()
    let nameLabel = UILabel()
    let nickNameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    var presenter: Lentagram.ProfilePresenterProtocol?
    
    func updateView(data: Lentagram.Profile) {
        nameLabel.text = data.name
        nickNameLabel.text = data.loginName
        descriptionLabel.text = data.bio
    }
    
    func setAvatar(url: URL) {}
}
