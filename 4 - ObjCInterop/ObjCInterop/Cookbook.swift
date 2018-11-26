//
//  Cookbook.swift
//  ObjCInterop
//
//  Created by Florent Vilmart on 18-05-28.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

class Step: Equatable {
    static func == (lhs: Step, rhs: Step) -> Bool {
        return lhs.instructions == rhs.instructions
    }

    let instructions: String = ""
    weak var delegate: StepDelegate?
}

extension Step {
    func complete() {
        delegate?.didComplete(step: self)
    }
}

class Recipe {
    let steps: [Step]
    init(steps: [Step]) {
        self.steps = steps
    }
}

protocol StepDelegate: NSObjectProtocol {
    func didComplete(step: Step)
}

protocol RecipeCookingManagerDelegate: NSObjectProtocol {
    func manager(_ manager: RecipeCookingManager, didComplete recipe: Recipe)
}

class RecipeCookingManager: NSObject {
    weak var delegate: RecipeCookingManagerDelegate?
    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func start() -> Step {
        guard let step = recipe.steps.first else { fatalError() }
        run(step: step)
        return step
    }

    private func run(step: Step) {
        step.delegate = self
    }
}

extension RecipeCookingManager: StepDelegate {
    func didComplete(step: Step) {
        step.delegate = nil // no need for the delegate anymore
        if let nextStepIndex = recipe.steps.index(of: step)?.advanced(by: 1),
            nextStepIndex < recipe.steps.count  {
            run(step: recipe.steps[nextStepIndex])
        } else {
            delegate?.manager(self, didComplete: self.recipe)
        }
    }
}



