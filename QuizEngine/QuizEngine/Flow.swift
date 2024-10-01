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
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
        router.routeTo(result: [:])
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            
            let currentQuestionIndex = strongSelf.questions.firstIndex(of: question)!
            let nextQuestion = strongSelf.questions[currentQuestionIndex+1]
            strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
        }
        
    }
}
