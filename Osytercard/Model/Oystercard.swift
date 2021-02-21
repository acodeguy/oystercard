import Foundation

/// An `Oystercard` used for travel on TfL in-place of using cash
class Oystercard {

    /// The current balance of this card
    var balance: Double = 0

    /// The station at which the card was last touched-in
    private(set) var entryStation: Station?

    /// Tracks if a journey is currently in-progress
    var isInJourney: Bool {
        return entryStation == nil ? false : true
    }

    /// The maximum balance allowed
    private let maximumBalance: Double = 90.00

    /// The minimum balance allowed to travel
    private let minimumFare: Double = 1.00

    /// Reduces the card's balance by the supplied amount
    private func deduct(_ amount: Double) {
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
    func touchIn(at station: Station) throws {
        if balance >= minimumFare {
            entryStation = station
        } else {
            throw OystercardError.balanceLowerThanMinimumFare
        }
    }

    /// Touch-out at an Oystercard gate
    func touchOut() {
        entryStation = nil
        deduct(minimumFare)
    }
}

/// Errors that can be thrown by an Oystercard
enum OystercardError: Error {
    case maximumBalanceExceeded
    case balanceLowerThanMinimumFare
}
