//
//  QuestionController.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-06.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class QuestionController {
    private var questions = [Question]()

    init() { load() }

    internal init(questions: [Question]) {
        self.questions = questions
    }

    // Load the questions from memory or disk
    func load() {
        questions = [
            Question(question: "Are you drunk", answer: .false)
        ].reversed()
    }

    func next() -> Question? {
        return questions.popLast()
    }
}
