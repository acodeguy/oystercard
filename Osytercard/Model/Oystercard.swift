import Foundation

/// An `Oystercard` used for travel on TfL in-place of using cash
class Oystercard {

    /// The current balance of this card
    var balance: Double = 0

    /// Tracks if a journey is currently in-progress
    var isInJourney: Bool = false

    /// The maximum balance allowed
    private let maximumBalance: Double = 90.00

    /// The minimum balance allowed to travel
    private let minimumFare: Double = 1.00

    /// Reduces the card's balance by the supplied amount
    func deduct(_ amount: Double) {
        balance -= amount
    }

    /// Increase this card's balance by the supplied amount
    func topup(_ amount: Double) throws {
        let projectedBalance = balance + amount
        if projectedBalance < maximumBalance {
            balance += amount
        } else {
            throw OystercardError.maximumBalanceExceeded
        }
    }

    /// Touch-in at an Oystercard gate
    func touchIn() throws {
        if balance >= minimumFare {
            isInJourney = true
        } else {
            isInJourney = false
            throw OystercardError.balanceLowerThanMinimumFare
        }
    }

    /// Touch-out at an Oystercard gate
    func touchOut() {
        isInJourney = false
    }
}

/// Errors that can be thrown by an Oystercard
enum OystercardError: Error {
    case maximumBalanceExceeded
    case balanceLowerThanMinimumFare
}
