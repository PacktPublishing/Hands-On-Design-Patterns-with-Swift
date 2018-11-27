//
//  Builder.swift
//  FactoryMethods
//
//  Created by Florent Vilmart on 18-05-31.
//  Copyright © 2018 flovilmart. All rights reserved.
//

import Foundation

func randomIdGenerator() -> String {
    return "..."
}

protocol Buildable {}
protocol AutoCopy {}
protocol AutoMutableCopy {}
protocol AutoMutable {}

class Article: Buildable, AutoCopy, AutoMutableCopy, AutoMutable {

    private(set) var id: String
    private(set) var title: String
    private(set) var contents: String
    private(set) var author: String
    private(set) var date: Date
    private(set) var views: Int = 10

    init(id: String,
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


func editContents(article: Article, contents: String) -> MutableArticle {
    let copy: MutableArticle = article.mutableCopy() as! MutableArticle
    copy.contents = contents
    return copy
}

//class MutableArticle: Article {
//    var id: String
//    var title: String
//    var contents: String
//    var author: String
//    var date: Date
//    var views: Int = 10
//
//    init(id: String,
//         title: String,
//         contents: String,
//         author: String,
//         date: Date,
//         views: Int) {
//        self.id = id
//        self.title = title
//        self.contents = contents
//        self.author = author
//        self.date = date
//        self.views = views
//    }


//extension Article {
//    class Builder {
//        private var id: String = randomIdGenerator()
//        private var title: String?
//        private var message: String?
//        private var author: String?
//        private var date: Date = Date()
//        private var views: Int = 0
//
//        func set(id: String) -> Builder {
//            self.id = id
//            return self
//        }
//
//        func set(title: String) -> Builder {
//            self.title = title
//            return self
//        }
//        func set(message: String) -> Builder {
//            self.message = message
//            return self
//        }
//        func set(author: String) -> Builder {
//            self.author = author
//            return self
//        }
//        func set(date: Date) -> Builder {
//            self.date = date
//            return self
//        }
//        func set(views: Int) -> Builder {
//            self.views = views
//            return self
//        }
//
//        func build() -> Article {
//            return Article(
//                id: id,
//                title: title!,
//                message: message!,
//                author: author!,
//                date: date,
//                views: views)
//        }
//    }
//}
//
//
//func createArticle() {
//    let article = Article.Builder()
//        .set(title: "")
//        .set(message: "")
//        .build()
//}

func getTitle() -> String { fatalError() }

func show(_ article: Article) {}

func ask(_ string: String) -> Bool {
    return false
}


