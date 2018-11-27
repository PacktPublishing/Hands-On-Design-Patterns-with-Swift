//
//  main.swift
//  MVC
//
//  Created by Florent Vilmart on 2018-08-06.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

print("Hello, World!")

//let controller = ApplicationController()
//controller.start()

let viewModel = ViewModel()
let view = View(viewModel: viewModel)
viewModel.start()

