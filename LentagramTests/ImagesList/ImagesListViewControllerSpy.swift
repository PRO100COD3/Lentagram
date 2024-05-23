import Foundation
import Lentagram

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: Lentagram.ImagesListPresenterProtocol?
    var updateTableViewAnimatedWasCalled: Bool = false
    
    func viewDidLoad() {
        presenter?.fetchPhotosNextPage()
    }
    
    func updateTableViewAnimated() {
        updateTableViewAnimatedWasCalled = true
    }
}
