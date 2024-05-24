import XCTest

final class LentagramUITests: XCTestCase {
    private let email: String = ""
    private let password: String = ""
    private let fullName: String = ""
    private let username: String = ""
    
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }
    
    func testAuth() throws {
        sleep(5)
        
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews[ "UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 20))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 20))
        
        loginTextField.tap()
        loginTextField.typeText(email)
        app.buttons["Done"].tap()
        sleep(5)
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        app.buttons["Done"].tap()
        webView.swipeUp()
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 15))
    }
    
    func testFeed() throws {
        sleep(5)
        
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["Like button"].tap()
        sleep(10)
        
        cellToLike.buttons["Like button"].tap()
        sleep(10)
        
        cellToLike.tap()
        sleep(30)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["Nav back button white"]
        navBackButtonWhiteButton.tap()
    }
    
    func testProfile() throws {
        sleep(10)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts[fullName].exists)
        XCTAssertTrue(app.staticTexts[username].exists)
        
        app.buttons["Logout button"].tap()
        
        app.alerts["До скорых встреч!"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
