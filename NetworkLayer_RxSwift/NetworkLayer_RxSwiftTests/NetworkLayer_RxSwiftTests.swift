//
//  NetworkLayer_RxSwiftTests.swift
//  NetworkLayer_RxSwiftTests
//
//  Created by Abdelrahman Mahmoud on 12/12/19.
//  Copyright © 2019 Abdelrahman Mahmoud. All rights reserved.
//

import XCTest
@testable import NetworkLayer_RxSwift

class NetworkLayer_RxSwiftTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testCallDataServices() {
        let urlPath = "https://testingq.getsandbox.com/User"
        let promise = expectation(description: "API Call Succeeded")
        
        let observable = NetworkLayer.shared.callDataService(urlPath: urlPath, method: HTTPMethod.GET, timeOutInterval: 20.0, responseClass: User.self)
        if let observableData = observable {
            observableData.subscribe(onNext:{ user in
            print(user.iD)
            }).dispose()
        }
    }
}
