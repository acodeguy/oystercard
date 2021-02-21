import Foundation

/// An `Oystercard` used for travel on TfL in-place of using cash
class Oystercard {

    /// The current balance of this card
    var balance: Double = 0

    /// The maximum balance allowed
    private let maximumBalance: Double = 90.00

    /// Increase this card's balance by the supplied amount
    func topup(_ amount: Double) throws {
        let projectedBalance = balance + amount
        if projectedBalance < maximumBalance {
            balance += amount
        } else {
            throw TopupError.maximumBalanceExceeded
        }
    }
}

enum TopupError: Error {
    case maximumBalanceExceeded
}
