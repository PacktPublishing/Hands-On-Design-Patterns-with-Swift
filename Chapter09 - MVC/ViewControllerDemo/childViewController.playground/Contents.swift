//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class HeaderController: UIViewController {

    var buttonTapped: (()->())?

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 100, width: 80, height: 80)
        let button = UIButton(type: .custom)
        button.setTitle("View More", for: .normal)
        button.addTarget(self, action: #selector(viewMore), for: .touchUpInside)
        button.frame = CGRect(x: 10, y: 10, width: 100, height: 40)
        view.addSubview(button)
        view.backgroundColor = .darkGray
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .custom
         transitioningDelegate = self
    }

    @objc func viewMore() {
        buttonTapped?()
    }
}

extension HeaderController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        print("Requesting tranistion")
        return nil
    }


    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

class MyViewController : UIViewController {
    let header = HeaderController()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        header.buttonTapped = { [unowned self] in
            self.togglePresentedHeader()
        }
    }

    func setupHeader() {
        let childController = header
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
        childController.view?.frame = CGRect(x: 0, y: 44, width: view.frame.width, height: 100)
        childController.view?.translatesAutoresizingMaskIntoConstraints = true
        childController.view?.autoresizingMask = [.flexibleWidth]
    }

    func add(_ childController: UIViewController, 
             with animations: (() -> Void)?,
             duration: TimeInterval? = nil) {
        addChild(childController)
        view.addSubview(childController.view)
        if let animations = animations,
            let duration = duration {
            UIView.animate(withDuration: duration, animations: animations) { (done) in
                childController.didMove(toParent: self)
            }
        } else {
            childController.didMove(toParent: self)
        }
    }

    func togglePresentedHeader() {
        if header.presentingViewController != nil {
            return dismiss(animated: true, completion: {
                self.setupHeader()
            })
        }
        // Remove from the parent first to prevent a crash
        header.willMove(toParent: nil)
        header.removeFromParent()
        present(header, animated: true, completion: nil)
    }

    @objc func tapped() {}
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = UINavigationController(rootViewController: MyViewController())
