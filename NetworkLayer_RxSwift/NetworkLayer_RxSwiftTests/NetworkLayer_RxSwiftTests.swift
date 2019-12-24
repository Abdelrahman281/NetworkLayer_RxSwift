//
//  NetworkLayer_RxSwiftTests.swift
//  NetworkLayer_RxSwiftTests
//
//  Created by Abdelrahman Mahmoud on 12/12/19.
//  Copyright © 2019 Abdelrahman Mahmoud. All rights reserved.
//

import XCTest
import RxSwift
@testable import NetworkLayer_RxSwift

class NetworkLayer_RxSwiftTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    
    //Sample function for Unit Testing.
    
    func testCallDataServices() {
        let urlPath = "https://testingq.getsandbox.com/User"
        
        //Creating XCTestExpectation for expecting API Success.
        let promise = expectation(description: "API Call Succeeded")
        
        let disposeBag = DisposeBag()
        
        NetworkLayer.shared.callDataService(urlPath: urlPath, method: HTTPMethod.GET, timeOutInterval: 20.0, responseClass: User.self)?.subscribe(onNext: { user in
            print("User: \(user.iD)")
            
            //Matched the expectation.
            promise.fulfill()
            
        }, onError: { error in
            print("hError: \(error)")
            
            //Failure case.
            XCTFail()
            
        }).disposed(by: disposeBag)
        
        wait(for: [promise], timeout: 20.0)
    }
}
