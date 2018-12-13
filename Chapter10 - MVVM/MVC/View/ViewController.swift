//
//  ViewController.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-06.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class ViewController {
    private let questionView = QuestionView()
    private let promptView = PromptView()
    func ask(question: Question) {
        questionView.show(question: question)
        promptView.show()
    }
}
