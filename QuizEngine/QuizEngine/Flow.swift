//
//  Flow.swift
//  QuizEngine
//
//  Created by Julius on 01/10/2024.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let questions: [String]
    private let router: Router
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            //Only delegate a message if there is something
            self?.routeNext(question, answer)
        }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[currentQuestionIndex+1]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
