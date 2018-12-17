//
//  MVVM.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-18.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class ViewModel {
    private let questions: QuestionController
    private var currentQuestion: Question? = nil {
        didSet { onQuestionChanged?() }
    }

    init(questions: QuestionController = QuestionController()) {
        self.questions = questions
    }

    var onQuestionChanged: (() -> Void)?
    var onAnswer: ((Bool) -> Void)?

    func getQuestionText() -> String? {
        return currentQuestion?.question
    }

    func start() {
        while let question = nextQuestion() {
            waitForAnswer(question: question)
        }
    }

    internal func waitForAnswer(question: Question) {
        let result = readLine()
        onAnswer?(question.isGoodAnswer(result: result))
    }

    internal func nextQuestion() -> Question? {
        currentQuestion = questions.next()
        return currentQuestion
    }
}

class View {
    private let questionView = QuestionView()
    private let promptView = PromptView()

    let viewModel: ViewModel
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.onQuestionChanged = { [unowned self] in
            guard let string = self.viewModel.getQuestionText() else {
                // No more questions?
                self.finishPlaying()
                return
            }
            self.ask(question: string)
        }
        viewModel.onAnswer = { [unowned self] (isGood) -> Void in
            if isGood {
                self.goodAnswer()
            } else {
                self.badAnswer()
            }
        }
    }

    private func ask(question: String) {
        questionView.show(question)
        promptView.show()
    }

    private func goodAnswer() { /* implement me */ }
    private func badAnswer() { /* implement me */ }
    private func finishPlaying() { /* implement me */ }
}
