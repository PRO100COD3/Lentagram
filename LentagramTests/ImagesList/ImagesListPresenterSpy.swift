import Foundation
import Lentagram

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var view: Lentagram.ImagesListViewControllerProtocol?
    var fetchPhotosNextPageWasCalled: Bool = false
    
    func fetchPhotosNextPage() {
        fetchPhotosNextPageWasCalled = true
    }
}
