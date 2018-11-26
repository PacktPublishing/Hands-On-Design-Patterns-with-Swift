import Cocoa

var str = "Hello, playground"

extension NotificationCenter {
    static let ui = NotificationCenter()
    static let model = NotificationCenter()
}

let modelChangedNotification: Notification.Name = Notification.Name(rawValue: "ModelChangedNotification")
let saveTappedNotification: Notification.Name = Notification.Name(rawValue: "SaveTappedNotification")

struct Model {
    var title: String = ""
    var description: String = ""
}

class ModelController {

    private var uiObserver: NSObjectProtocol!

    init() {
        uiObserver = NotificationCenter.ui.addObserver(
            forName: saveTappedNotification,
            object: nil,
            queue: nil) { [unowned self] (notification) in
                guard let model = notification.object as? Model else { return }
                self.save(model: model)
        }
    }

    func loadModel() {
        let model = Model()
        NotificationCenter.model.post(name: modelChangedNotification, object: model)
    }

    func save(model: Model) {
        var model = model
        // Ensure the title length is never > 20 chars
        model.title = String(model.title.prefix(20))
        // Save the model...
        // Then emit back so we can update the UI
        NotificationCenter.model.post(name: modelChangedNotification, object: model)
    }

    deinit {
        NotificationCenter.ui.removeObserver(uiObserver)
    }
}

class ViewController {
    private var modelObserver: NSObjectProtocol!
    var model: Model? = nil

    init() {
        modelObserver = NotificationCenter.model.addObserver(
            forName: modelChangedNotification,
            object: nil,
            queue: nil) { [unowned self] (notification) in
                guard let model = notification.object as? Model else { return }
                self.handle(model: model)
        }
    }

    private func handle(model: Model) {
        self.model = model
        // Print it, our display is the console
        print("\(model)")
    }

    func saveButtonTapped() {
        NotificationCenter.ui.post(
            name: saveTappedNotification,
            object: self.model)
    }


    deinit {
        NotificationCenter.model.removeObserver(modelObserver)
    }
}


let modelControler = ModelController()
let uiController = ViewController()

modelControler.loadModel()
uiController.model?.title = "Hi! There"
uiController.saveButtonTapped()

uiController.model?.title = "When gone am I, the last of the Jedi will you be. The Force runs strong in your family. Pass on what you have learned."
uiController.saveButtonTapped()


import AppKit

let view = NSView(frame: .zero)
//let observer = view.observe(\NSView.frame) { (view, change) in
//    print("\(view.frame), \(change.oldValue) \(change.newValue)")
//}

//let observer = view.observe(\NSView.frame, options: [.new, .old]) { (view, change) in
//    print("\(view.frame), \(change.oldValue!) \(change.newValue!)")
//}
//
//
//view.frame = NSRect(x: 0, y: 0, width: 100, height: 100)
//view.frame = NSRect(x: 0, y: 0, width: 100, height: 200)
//
//observer.invalidate()


class MyObject: NSObject {
    @objc dynamic var string: String = ""
}

let object = MyObject()
var changed = false
object.observe(\MyObject.string) { (obj, change) in
    // Do Something with the new value
    changed = true
}

object.string = "This will emit an event"
print("changed \(changed)")

struct Article {
    var title: String = "" {
        willSet {
            // here the title is the value before setting
            if title != newValue {
                print("The value will change \(newValue)")
            }
        }
        didSet {
            // here the title is the value after it's been set
            if title != oldValue {
                print("The value has changed \(oldValue)")
            }
        }
    }
}

var article = Article()
article.title = "A Good Title"
article.title = "A Good Title"
article.title = "A Better Title"
