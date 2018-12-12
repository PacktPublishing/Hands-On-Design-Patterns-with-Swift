//: Playground - noun: a place where people can play

import Foundation

class CreditCard {
    enum ChargeError: Error {
        case invalidAmount
        case insufficientFunds
    }

    private(set) var balance: Int // balance is in cents
    init(balance: Int) {
        self.balance = balance
    }
    func charge(amount: Int) throws {
        guard amount >= 0 else { throw ChargeError.invalidAmount }
        guard balance >= amount else { throw ChargeError.insufficientFunds }

        balance -= amount
    }
}

let card = CreditCard(balance: 10000)
do {
    try card.charge(amount: 2000)
} catch CreditCard.ChargeError.invalidAmount {
    /* handle invalidAmount */
} catch CreditCard.ChargeError.insufficientFunds {
    /* handle insufficientFunds */
} catch {}


