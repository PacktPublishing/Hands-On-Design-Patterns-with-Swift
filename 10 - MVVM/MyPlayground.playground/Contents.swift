import UIKit
import PlaygroundSupport

var str = "Hello, playground"


let observable = Observable<String?>("Let's get started")
var textField = UITextField(frame: .zero)
textField.bind(observable)
print("\(textField.text!)")
observable.value = "Are you Ready?"
print("\(textField.text!)")
textField.text = "YES!"
textField.sendActions(for: .valueChanged)
print("\(observable.value!)")

class SignupPayload: Codable {
    let username: String
    let email: String
    let age: Double
}

class ViewModel {
    var username = Observable<String?>(nil)
    var email = Observable<String?>(nil)
    var age = Observable<Double>(0.0)

    var description: String {
        return """
username: \(username.value ?? "")
email: \(email.value ?? "")
age: \(age.value)
"""
    }
}

class ViewController: UIViewController {
    let ageStepper = UIStepper(frame: CGRect(x: 0, y: 300, width: 400, height: 50))
    let ageLabel = UILabel(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
    let usernameTextField = UITextField(frame: CGRect(x: 0, y: 200, width: 400, height: 50))
    let emailField = UITextField(frame: CGRect(x: 0, y: 100, width: 400, height: 50))

    let button = UIButton(frame: CGRect(x: 0, y: 400, width: 100, height: 50))

    var viewModel: ViewModel! {
        didSet {
            ageStepper.bind(viewModel.age)
            viewModel.age.bind { (age) in
                self.ageLabel.text = "age: \(age)"
            }
            usernameTextField.bind(viewModel.username)
            emailField.bind(viewModel.email)
        }
    }


    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 400))
        self.view = view
        view.backgroundColor = .white
        usernameTextField.borderStyle = .bezel
        emailField.borderStyle = .bezel
        button.setTitle("PRINT", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(printForm), for: .touchUpInside)
        view.addSubview(usernameTextField)
        view.addSubview(emailField)
        view.addSubview(ageStepper)
        view.addSubview(ageLabel)
        ageLabel.text = "age: "
        view.addSubview(button)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func printForm() {
        print(viewModel.description)
    }
}

let viewController = ViewController()
let model = ViewModel()
viewController.viewModel = model

PlaygroundPage.current.liveView = viewController

