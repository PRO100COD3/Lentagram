import UIKit
import WebKit
import Kingfisher

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func updateView(data: Profile)
    func setAvatar(url: URL)
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    private let imageView = UIImageView()
    private let exitButton = UIButton()
    private let nameLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    var presenter: ProfilePresenterProtocol?
    
    private let mockProfile = Profile(username: "username", name: "name", loginName: "loginName", bio: "bio")
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage()
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenter(view: self)
        
        setupView()
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.updateAvatar()
            }
        presenter?.updateAvatar()
        presenter?.updateProfileDetails()
    }
    
    @objc
    private func didTapButton() {
        showAlert()
    }
}

extension ProfileViewController {
    func showAlert() {
        let alert = UIAlertController(
            title: "До скорых встреч!",
            message: "Уверены что хотите выйти?",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(
            title: "Да",
            style: .default) { _ in
                alert.dismiss(animated: true)
                self.presenter?.logout()
                
                guard let window = UIApplication.shared.windows.first else {
                    assertionFailure("confirmExit Invalid Configuration")
                    return
                }
                window.rootViewController = SplashViewController()
            }
        
        let noAction = UIAlertAction(
            title: "Нет",
            style: .default) { _ in
                alert.dismiss(animated: true)
            }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    func updateView(data: Profile) {
        nameLabel.text = data.name
        nickNameLabel.text = data.loginName
        descriptionLabel.text = data.bio
    }
    
    func setAvatar(url: URL) {
        imageView.kf.setImage(with: url)
    }
    func deleteAvatar(){
        imageView.image = UIImage(named: "No Photo")
    }
}

extension ProfileViewController {
    private func setupView() {
        view.backgroundColor = .ypBlack
        profileImageConfig()
        exitButtonConfig()
        nameLabelConfig()
        nickNameLabelConfig()
        descriptionLabelConfig()
    }
    
    private func profileImageConfig() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func exitButtonConfig() {
        let exitButton = UIButton.systemButton(with: UIImage(named: "Exit") ?? UIImage(), target: self, action: #selector(Self.didTapButton))
        exitButton.tintColor = UIColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1.0)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        exitButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        exitButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        exitButton.tintColor = UIColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1.0)
    }
    
    private func nameLabelConfig() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.font = UIFont(name: "SFPro-Regular", size: 23.0)
        nameLabel.textColor = .white
    }
    
    private func nickNameLabelConfig() {
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nickNameLabel)
        
        nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nickNameLabel.textColor = .gray
        nickNameLabel.font = UIFont(name: "SFPro-Regular", size: 13.0)
    }
    
    private func descriptionLabelConfig() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name: "SFPro-Regular", size: 13.0)
    }
}
