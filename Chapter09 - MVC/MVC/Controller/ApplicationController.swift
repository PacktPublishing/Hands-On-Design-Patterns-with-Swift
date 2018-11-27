//
//  ApplicationController.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-06.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class ApplicationController {
    let questions = QuestionController()
    let view = ViewController()

    private func waitForAnswer(question: Question) {
        let result = readLine()
        if question.isGoodAnswer(result: result) {
            print("Good Job")
        } else {
            print("Too bad...")
        }
    }

    func start() {
        while let question = questions.next() {
            view.ask(question: question)
            waitForAnswer(question: question)
        }
        print("Thanks for playing!")
    }
}
