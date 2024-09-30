import Foundation
import Lentagram

final class WebViewViewControllerSpy: WebViewControllerProtocol {
    var presenter: Lentagram.WebViewPresenterProtocol?
    
    var loadRequestCalled: Bool = false
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {}
    
    func setProgressHidden(_ isHidden: Bool) {}
}
