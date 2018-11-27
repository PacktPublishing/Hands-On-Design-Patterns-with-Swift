//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

let postMessageAPIURL = URL(string: "https://")!

//class MassiveViewController : UIViewController {
//
//    var textView = UITextView()
//    var sendButton = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        /* layout the views */
//        /* design the views */
//    }
//
//    func sendTapped(sender: UIButton) {
//        if textView.text.count == 0 {
//            // display error
//        } else {
//            postMessage(message: textView.text) { (success, error) in
//                if success {
//                    // all good
//                    print(success)
//                } else if let error = error {
//                    // Show an error alert
//                    //
//                    print(error)
//                }
//            }
//        }
//    }
//
//    struct BooleanResponse: Codable {
//        let success: Bool
//    }
//
//    struct MessageRequest: Codable  {
//        let message: String
//    }
//
//    private func postMessage(message: String, callback: @escaping (Bool, Error?) ->  Void) {
//        let messagePayload = MessageRequest(message: message)
//        var request = URLRequest(url: postMessageAPIURL)
//        request.httpMethod = "POST"
//        do {
//            try request.httpBody = JSONEncoder().encode(messagePayload)
//        } catch let error {
//            callback(false, error)
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                callback(false, error)
//            } else if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(BooleanResponse.self, from: data)
//                    callback(result.success, nil)
//                } catch let error {
//                    callback(false, error)
//                }
//            }
//        }
//    }
//}
//
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MassiveViewController()

protocol ComposeViewControllerDelegate: AnyObject {
    func composeViewController(_ controller: ComposeViewController, attemptToSend message: String)
}

class ComposeViewController: UIViewController {
    enum State {
        case `default`
        case error(Error)
        case sending
    }

    private var textView = UITextView()
    private var sendButton = UIButton()

    weak var delegate: ComposeViewControllerDelegate?

    var state: State = .default {
        didSet { /* todo handle state */ }
    }

    func sendTapped(sender: UIButton) {
        delegate?.composeViewController(self, attemptToSend: textView.text)
    }
}

class PostMessageNetworking {
    func post(message: String, callback: @escaping (Bool, Error?) ->  Void) {
        /* original call */
    }
}

class MessageValidator {
    enum ValidationError: Error {
        case emptyMessage
    }

    func validate(message: String) -> ValidationError? {
        if message.count == 0 {
            return .emptyMessage
        }
        return nil
    }
}

class PostMessageController: ComposeViewControllerDelegate {
    let viewController = ComposeViewController()
    let validator = MessageValidator()
    let networking = PostMessageNetworking()

    init() {
        viewController.delegate = self
    }

    func composeViewController(_ viewController: ComposeViewController, attemptToSend message: String) {
        if let error = validator.validate(message: message) {
            viewController.state = .error(error)
            return
        }
        viewController.state = .sending
        networking.post(message: message) { (success, error) in
            if let error = error {
                viewController.state = .error(error)
            } else {
                viewController.state = .default
            }
        }
    }
}


let controller = PostMessageController()
PlaygroundPage.current.liveView = controller.viewController
