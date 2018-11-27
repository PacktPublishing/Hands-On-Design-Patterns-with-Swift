// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Article {
    class Builder {
        private var id: String?
        private var title: String?
        private var contents: String?
        private var author: String?
        private var date: Date?
        private var views: Int?

        func set(id: String) -> Builder {
            self.id = id
            return self
        }
        func set(title: String) -> Builder {
            self.title = title
            return self
        }
        func set(contents: String) -> Builder {
            self.contents = contents
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

        // MARK: builder
        func build() -> Article {
            return Article(
id: id!,
title: title!,
contents: contents!,
author: author!,
date: date!,
views: views!)

        }
    }
}
