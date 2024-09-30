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
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}

final class QuizEngineTests: XCTestCase {
    func test_start_withNoQuestionDoesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestionRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
//    
    func test_start_withOneQuestionRouteToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestionsRouteToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestionsRouteToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    class RouterSpy: Router {
        var routedQuestions = [String]()
        
        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }

}
