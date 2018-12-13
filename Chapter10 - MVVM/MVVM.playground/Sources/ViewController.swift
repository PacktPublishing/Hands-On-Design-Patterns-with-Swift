import UIKit

class SignupViewModel {
    var username = Observable<String?>(nil)
    var email = Observable<String?>(nil)
    var age = Observable<Double>(0.0)
}
extension SignupViewModel  {
    var description: String {
        return """
        username: \(username.value ?? "")
        email: \(email.value ?? "")
        age: \(age.value)
        """
    }
}

class SignupViewController: UIViewController {
    @IBOutlet var ageStepper: UIStepper!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var emailField: UITextField!
    var viewModel: ViewModel! {
        didSet {
            bindViewModel()
        }

    }
    func bindViewModel() {
        // Ensure the view is loaded
        guard isViewLoaded else { return }
        ageStepper.bind(viewModel.age)
        usernameField.bind(viewModel.username)
        emailField.bind(viewModel.email)
        // Bind the viewModel.age value to the label
        // The stepper update the viewModel, which update the label
        viewModel.age.bind { (age) in
            self.ageLabel.text = "age: \(age)"
        }
    }

}
