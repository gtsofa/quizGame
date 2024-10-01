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
        makeSUT(questions: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestionRouteToQuestion() {
        makeSUT(questions: ["Q1"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
//    
    func test_start_withOneQuestionRouteToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestionsRouteToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestionsRouteToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestionsRouteToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_start_withNoQuestionsRouteToResult() {
        let sut = makeSUT(questions: [])
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, [])
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_start_withOneQuestionsDoesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestionsRouteToResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
        XCTAssertEqual(router.routedResult, ["Q1": "A1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestionsRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    
    private func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
    
    class RouterSpy: Router {
        var routedQuestions = [String]()
        var answerCallback: Router.AnswerCallback = { _ in }
        var routedResult: [String: String]? = nil
        
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }

}
