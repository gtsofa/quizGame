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
    private let questions: [String]
    private let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if !questions.isEmpty {
            router.routeTo(question: "Q1")
        }
    }
}

final class QuizEngineTests: XCTestCase {
    func test_start_withNoQuestionDoesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestionRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
//    
//    func test_startTwice_routeToQuestionTwice() {
//        let router = RouterSpy()
//        let sut = Flow(router: router)
//        
//        sut.start()
//        sut.start()
//        
//        XCTAssertEqual(router.routedQuestions, 2)
//        XCTAssertEqual(router.routedQuestion, "Q1", "Q2")
//    }
    
    class RouterSpy: Router {
        var routedQuestionCount = 0
        
        func routeTo(question: String) {
            routedQuestionCount += 1
        }
    }

}
