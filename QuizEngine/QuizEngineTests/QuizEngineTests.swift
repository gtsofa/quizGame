//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by Julius on 30/09/2024.
//

import XCTest

protocol Router {
    func routeTo(question: String)
}

class Flow {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        router.routeTo(question: "Q1")
    }
}

final class QuizEngineTests: XCTestCase {
    func test_init_doesNotRouteToQuestion() {
        let router = RouterSpy()
        _ = Flow(router: router)
        
        XCTAssertEqual(router.routedQuestions, 0)
    }
    
    func test_start_routeToQuestion() {
        let router = RouterSpy()
        let sut = Flow(router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, 1)
    }
    
    class RouterSpy: Router {
        var routedQuestions = 0
        
        func routeTo(question: String) {
            routedQuestions += 1
        }
    }

}
