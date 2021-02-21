import Foundation

/// An `Oystercard` used for travel on TfL in-place of using cash
class Oystercard {

    /// The current balance of this card
    var balance: Double = 0

    /// Increase this card's balance by the supplied amount
    func topup(_ amount: Double) {
        balance += amount
    }
}
