//
//  MVVMTestging.swift
//  MVVMTestging
//
//  Created by Florent Vilmart on 2018-08-18.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import XCTest

class ViewModelTesting: XCTestCase {

    func testCallsNextQuestion() {
        let viewModel = ViewModel(questions: QuestionController(questions: [Question(question: "OK", answer: .true)]))
        var called = false
        viewModel.onQuestionChanged = {
            called = true
        }
        let question  = viewModel.nextQuestion()
        XCTAssert(called)
        XCTAssertNotNil(question)
    }

    func testFinished() {
        let viewModel = ViewModel(questions: QuestionController(questions: []))
        var called = false
        viewModel.onQuestionChanged = {
            called = true
        }
        let question  = viewModel.nextQuestion()
        XCTAssertNil(question)
        XCTAssertNil(viewModel.getQuestionText())
        XCTAssert(called)
    }
}
