import Foundation
import Lentagram

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: Lentagram.ProfileViewControllerProtocol?
    var updateProfileDetailsWasCalled: Bool = false
    var updateAvatarWasCalled: Bool = false
    var logoutWasCalled: Bool = false
    
    func updateProfileDetails() {
        updateProfileDetailsWasCalled = true
    }
    
    func updateAvatar() {
        updateAvatarWasCalled = true
    }
    
    func logout() {
        logoutWasCalled = true
    }
}
