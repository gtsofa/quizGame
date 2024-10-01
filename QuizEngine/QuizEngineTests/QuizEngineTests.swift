//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by Julius on 30/09/2024.
//

import XCTest
@testable import QuizEngine

final class QuizEngineTests: XCTestCase {
    let router = RouterSpy()
    
    func test_start_withNoQuestionDoesNotRouteToQuestion() {
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestionRouteToQuestion() {
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
//    
    func test_start_withOneQuestionRouteToCorrectQuestion() {
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestionsRouteToFirstQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestionsRouteToFirstQuestionTwice() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestionsRouteToSecondQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        
        sut.start()
        router.answerCallback!("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    // MARK: - Helper
    
    private func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
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
