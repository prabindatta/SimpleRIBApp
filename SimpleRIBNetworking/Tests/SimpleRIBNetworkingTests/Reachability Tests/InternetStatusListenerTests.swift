//
//  InternetStatusListenerTests.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import XCTest
@testable import SimpleRIBNetworking

class InternetStatusListenerTests: XCTestCase {
    
    func testInternetStatusListenerForInternetChangingStatus() throws {
        
        let mock = AFReachabilityManagerMock()
        
        let listener = InternetStatusListener(afReachabilityManager: mock)
        
        XCTAssertEqual(listener.currentStatus, .notReachable)
        
        listener.startMonitoring()
        
        XCTAssertTrue(mock.didCallStartListening)
        
        mock.sendStatus(.reachable(.cellular))
        XCTAssertEqual(listener.currentStatus, InternetStatus.reachable)
        
        mock.sendStatus(.notReachable)
        XCTAssertEqual(listener.currentStatus, InternetStatus.notReachable)
        
        mock.sendStatus(.unknown)
        XCTAssertEqual(listener.currentStatus, InternetStatus.notReachable)
        
        mock.sendStatus(.reachable(.cellular))
        XCTAssertEqual(listener.currentStatus, InternetStatus.reachable)
    }
}
