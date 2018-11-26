// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Article {
    class Builder {
        private var id: String?
        private var title: String?
        private var message: String?
        private var author: String?
        private var date: Date?
        private var views: Int?
        private var some: Int??

        func set(id: String) -> Builder {
            self.id = id
            return self
        }
        func set(title: String) -> Builder {
            self.title = title
            return self
        }
        func set(message: String) -> Builder {
            self.message = message
            return self
        }
        func set(author: String) -> Builder {
            self.author = author
            return self
        }
        func set(date: Date) -> Builder {
            self.date = date
            return self
        }
        func set(views: Int) -> Builder {
            self.views = views
            return self
        }
        func set(some: Int?) -> Builder {
            self.some = some
            return self
        }

        // MARK: builder
        func build() -> Article {
            return Article(
                    id: id!,
                    title: title!,
                    message: message!,
                    author: author!,
                    date: date!,
                    views: views!,
                    some: some!)
        }
    }
}
