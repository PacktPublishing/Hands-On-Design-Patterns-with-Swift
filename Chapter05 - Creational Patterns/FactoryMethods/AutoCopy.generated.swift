// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Article: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Article(
            id: id,
            title: title,
            contents: contents,
            author: author,
            date: date,
            views: views)
    }
}

class MutableArticle {
    var id: String
    var title: String
    var contents: String
    var author: String
    var date: Date
    var views: Int

    init(
         id: String,
         title: String,
         contents: String,
         author: String,
         date: Date,
         views: Int) {
        self.id = id
        self.title = title
        self.contents = contents
        self.author = author
        self.date = date
        self.views = views
    }
}


extension Article: NSMutableCopying {
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        return MutableArticle(
            id: id,
            title: title,
            contents: contents,
            author: author,
            date: date,
            views: views)
    }
}
