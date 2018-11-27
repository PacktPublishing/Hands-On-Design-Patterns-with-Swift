import Foundation
import AppKit

class MyView: NSView  {
    let image: NSImage!
    let imageView = NSImageView(frame: .zero)

    init(imageName: NSImage.Name, frame: NSRect) {
        image = NSImage(named: imageName)
        super.init(frame: frame)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(imageView)
        imageView.frame = bounds.insetBy(dx: 5.0, dy: 5.0)
        imageView.image = image
        imageView.imageAlignment = .alignCenter
    }
}

class MyView2: NSView  {
    private let imageName: NSImage.Name
    lazy var image = NSImage(named: self.imageName)

    let imageView = NSImageView(frame: .zero)

    init(imageName: NSImage.Name, frame: NSRect) {
        self.imageName = imageName
        super.init(frame: frame)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(imageView)
        imageView.frame = bounds.insetBy(dx: 5.0, dy: 5.0)
        imageView.image = image
        imageView.imageAlignment = .alignCenter
    }
}

class MyView3: NSView  {
    private let imageName: NSImage.Name
    lazy var image = NSImage(named: self.imageName)
    lazy var imageView = NSImageView(frame: self.bounds.insetBy(dx: 5.0, dy: 5.0))

    init(imageName: NSImage.Name, frame: NSRect) {
        self.imageName = imageName
        super.init(frame: frame)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(imageView)
        imageView.image = image
        imageView.imageAlignment = .alignCenter
    }
}

