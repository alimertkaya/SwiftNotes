//
//  LoginProtocolOrientedTests.swift
//  LoginProtocolOrientedTests
//
//  Created by Ali Mert Kaya on 13.09.2023.
//

import XCTest
@testable import LoginProtocolOriented

final class LoginProtocolOrientedTests: XCTestCase {
    
    private var viewModel : RootViewModel!
    private var loginStorageService : MockLoginStorageService!
    private var output : MockRootViewModelOutput!

    override func setUpWithError() throws {
        
        loginStorageService = MockLoginStorageService()
        viewModel = RootViewModel(loginStorageService: loginStorageService)
        output = MockRootViewModelOutput()
        
        viewModel.output = output
        
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loginStorageService = nil
    }

    func testShowLogin_whenLoginStorageReturnsEmptyUserAccessToken() throws {
        loginStorageService.storage = [:]
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    
    func testShowLogin_whenLoginStorageReturnsEmptyString() throws {
        loginStorageService.storage["ACCESS_TOKEN"] = ""
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    
    func testShowMainApp_whenLoginStorageReturnsUserAccessToken() throws {
        loginStorageService.storage["ACCESS_TOKEN"] = "123123123412"
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .mainApp)
    }
}

class MockLoginStorageService : LoginStorageService {
    var userAccessTokenKey: String {
        return "ACCESS_TOKEN"
    }
    
    var storage : [String : String] = [:]
    
    func setUserAccessToken(token: String) {
        storage[userAccessTokenKey] = token
    }
    
    func getUserAccessToken() -> String? {
        return storage[userAccessTokenKey]
    }
}

class MockRootViewModelOutput : RootViewModelOutput {
    
    enum Check {
        case login
        case mainApp
    }
    
    var checkArray : [Check] = []
    
    func showLogin() {
        checkArray.append(.login)
    }
    
    func showMainApp() {
        checkArray.append(.mainApp)
    }
}
