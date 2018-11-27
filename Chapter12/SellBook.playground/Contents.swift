import Dispatch

struct Book {
    var title: String
    var author: String
    var price: Double
}

func sellBook(_ book: Book) -> () -> Double {
    var totalSales = 0.0
    func sell() -> Double {
        totalSales += book.price
        return totalSales
    }
    return sell
}

let bookA = Book(title: "BookA", author: "AuthorA", price: 10.0)
let bookB = Book(title: "BookB", author: "AuthorB", price: 13.0)

let sellBookA = sellBook(bookA)
let sellBookB = sellBook(bookB)
let sellBookC = sellBook(bookB)

// If you remove @escaping here, the compiler will complain
func delay(_ d: Double, fn: @escaping () -> ()) {
    DispatchQueue.global().asyncAfter(deadline: .now() + d) {
        DispatchQueue.main.async {
            fn()
        }
    }
}

// Ditto!
func sellAsync(_ seller: @escaping () -> Double) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        DispatchQueue.main.async {
            let r = seller()
            print(r)
        }
    }
}

// Check how the two books' sales are counted independently although
// you only have a single totalSales variable, lexically
sellBookA()
sellBookB()
sellBookA()
sellBookB()
sellBookA()
sellBookB()
sellBookB()
sellBookB()

sellBookC()

sellAsync(sellBookA)
sellAsync(sellBookA)

sellAsync(sellBookB)
sellAsync(sellBookB)
