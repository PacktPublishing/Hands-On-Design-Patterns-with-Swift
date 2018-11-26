import Cocoa

struct CardInfo: CustomStringConvertible {
    let id: Int = Int.random(in: 0..<1000)

    var description: String {
        return "CardInfo(id: \(id))"
    }

}

struct ReadError: Error, CustomStringConvertible {
    var localizedDescription: String {
        return "ReadError()"
    }

    var description: String {
        return "ReadError()"
    }
}

func tossCoin() -> Bool {
   return Int.random(in: 0..<10) >= 5
}

let seenCard = tossCoin
let readCard = tossCoin

class CardReader {

    enum State {
        case unknown
        case waiting
        case reading
        case read(CardInfo)
        case failed(Error)
    }

    var state: State = .unknown


    func start() {
        while true {
            print("\(state)")
            switch state {
            case .unknown:
                state = .waiting
            case .waiting:
                if seenCard() {
                    state = .reading
                }
            case .reading:
                if readCard() {
                    state = .read(CardInfo())
                } else {
                    state = .failed(ReadError())
                }
            case .read(_):
                // Card is read
                // Now we can do the payment or
                // open the gate
                state = .waiting
            case .failed(_):
                // Display an error message on the screen
                // Prompt to restart after a few seconds
                state = .waiting
            }
            sleep(1)
        }
    }
}

//let reader = CardReader()
//reader.start()

protocol CardReaderState {
    func perform(context: Reader)
}

struct UnknownState: CardReaderState {
    static let shared = UnknownState()
    func perform(context: Reader) {
        // Perform local initialization
        // When everyting is ready
        // Toggle the state to Waiting
        context.state = WaitingState()
    }
}

struct WaitingState: CardReaderState {
    static let shared = WaitingState()
    func perform(context: Reader) {
        guard seenCard() else { return }
        // we have seen a card!
        context.state = ReadingState()
    }
}

struct ReadingState: CardReaderState {
    static let shared = ReadingState()
    func perform(context: Reader) {
        // Read the contents of the card over the radio
        // This is quite complext and can take a while

        if readCard() {
            // Card was read
            context.state = ReadState(card: CardInfo())
        } else {
            context.state = ErrorState(error: ReadError())
        }
    }
}

struct ReadState: CardReaderState {
    let card: CardInfo
    func perform(context: Reader) {
        // Open the gates to the metro doors
        // And reset back to waiting
        context.state = WaitingState.shared
    }
}

struct ErrorState: CardReaderState {
    let error: Error
    func perform(context: Reader) {
        // display an error, and go back to waiting
        context.state = WaitingState()
    }
}



class Reader {
    internal var state: CardReaderState = UnknownState()

    func start() {
        while true {
            state.perform(context: self)
            print("\(state)")
            sleep(1)
        }
    }
}

//let cardReader = Reader()
//cardReader.start()

let center = NotificationCenter()

