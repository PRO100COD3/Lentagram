import Foundation
import Lentagram

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: Lentagram.ProfilePresenterProtocol?
    var updateViewWasCalled: Bool = false
    var setAvatarWasCalled: Bool = false
    
    func updateView(data: Lentagram.Profile) {
        updateViewWasCalled = true
    }
    
    func setAvatar(url: URL) {
        setAvatarWasCalled = true
    }
}
