//
//  TestCapTests.swift
//  TestCapTests
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import XCTest
@testable import TestCap

class TestCapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test case to test Complete fetching and parsing logic
    func testDataFetching() {
        let apiClient = FactsApiClient.init()
        // 1. Define an expectation
        let expectn = expectation(description: "Facts are fetched and Are parsed")
        
        // 2. Exercise the asynchronous code
        apiClient.fetchFeed(completionHandler: { (result) in
            switch result {
            case .response(let data):
                XCTAssertTrue(!data.isEmpty)
                break
            case .error(error: let error):
                XCTFail("Error occured with Fetching Data\(error.localizedDescription)")
                break
            }
            expectn.fulfill()
        })
        
        // 3. Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 4) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
