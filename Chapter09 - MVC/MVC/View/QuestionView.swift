//
//  QuestionView.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-06.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

struct QuestionView {
    func show(question: Question) {
        print(question.question)
    }

    func show(_ string: String) {
        print(string)
    }
}

struct PromptView {
    func show() {
        print("> ", terminator: "")
    }
}

