import Foundation


public protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol?{ get set }
    func fetchPhotosNextPage()
}

final class ImagesListPresenter: ImagesListPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?
    private let imagesListService = ImagesListService.shared
    
    init(view: ImagesListViewControllerProtocol? = nil) {
        self.view = view
    }
    
    func fetchPhotosNextPage() {
        imagesListService.fetchPhotosNextPage()
    }
}
