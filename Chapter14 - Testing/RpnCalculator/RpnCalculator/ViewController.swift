//
//  ViewController.swift
//  RpnCalculator
//
//  Created by Giordano Scalzo on 29/10/2018.
//  Copyright © 2018 Giordano Scalzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var line3: UITextField!
    @IBOutlet var line2: UITextField!
    @IBOutlet var line1: UITextField!
    @IBOutlet var line0: UITextField! {
        didSet {
            line0.accessibilityIdentifier = "ui.textfield.line0"
        }
    }
    private let rpnCalculator:RpnCalculator = FloatRpnCalculator()

    @IBAction func buttonDidTap(button: UIButton) {
        guard let element = button.title(for: .normal) else {
            return
        }
        rpnCalculator.new(element: element)
        line0.text = rpnCalculator.line0
        line1.text = rpnCalculator.line1
        line2.text = rpnCalculator.line2
        line3.text = rpnCalculator.line3
    }
}

