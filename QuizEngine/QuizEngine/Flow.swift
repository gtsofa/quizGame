//
//  Flow.swift
//  QuizEngine
//
//  Created by Julius on 01/10/2024.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
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
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let strongSelf = self else { return }
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex+1]
                strongSelf.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
