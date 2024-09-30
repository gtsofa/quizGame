//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by Julius on 30/09/2024.
//

import XCTest

protocol Router {}

class Flow {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
}

final class QuizEngineTests: XCTestCase {
    func test_init_doesNotRouteToQuestion() {
        let router = RouterSpy()
        _ = Flow(router: router)
        
        XCTAssertEqual(router.routedQuestions, 0)
    }
    
    class RouterSpy: Router {
        var routedQuestions = 0
    }

}
