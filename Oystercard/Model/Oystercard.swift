import Foundation

/// An `Oystercard` used for travel on TfL in-place of using cash
class Oystercard {

    /// The current balance of this card
    var balance: Double = 0

    /// The station at which the card was last touched-in
    private(set) var entryStation: Station?

    /// The station at which the card was touched-out
    private(set) var exitStation: Station?

    /// Calculates fares for the given journey
    private let fareCalculator: FareCalculator?

    /// Tracks if a journey is currently in-progress
    var isInJourney: Bool {
        return entryStation == nil ? false : true
    }

    /// The journeys made using this card
    var journeyHistory: JourneyHistory?

    /// The maximum balance allowed
    private let maximumBalance: Double = 90.00

    /// The minimum balance allowed to travel
    private let minimumFare: Double = 1.00

    /// Reduces the card's balance by the supplied amount
    private func deduct(_ amount: Double) {
        balance -= amount
    }

    // MARK: Lifecycle methods

    init(journeyHistory: JourneyHistory = JourneyHistory(), fareCalculator: FareCalculator = FareCalculator()) {
        self.journeyHistory = journeyHistory
        self.fareCalculator = fareCalculator
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
    func touchOut(at station: Station) {
        guard let journeyHistory = journeyHistory else {
            assertionFailure("No JourneyHistory found")
            return
        }

        guard let fareCalculator = fareCalculator else {
            assertionFailure("No FareCalculator found")
            return
        }

        let journey = Journey(entryStation: entryStation, exitStation: station)
        journeyHistory.add(journey)

        let fare = fareCalculator.fare(for: journey)
        deduct(fare)

        self.entryStation = nil
        self.exitStation = nil
    }
}

// MARK: - OystercardError

/// Errors that can be thrown by an Oystercard
enum OystercardError: Error {
    case maximumBalanceExceeded
    case balanceLowerThanMinimumFare
}
