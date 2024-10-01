//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by Julius on 30/09/2024.
//

import XCTest
@testable import QuizEngine

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
    
    func test_startAndAnswerFirstQuestion_withTwoQuestionsRouteToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        router.answerCallback!("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    class RouterSpy: Router {
        var routedQuestions = [String]()
        var answerCallback: ((String) -> Void)? = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }

}
