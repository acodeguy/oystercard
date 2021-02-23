import Foundation

// MARK: - JourneyHistory

/// Manages the journey history for a card
class JourneyHistory {

    // MARK: Properties

    /// The journey history items
    private(set) var journeys: [Journey] = []

    // MARK: Methods

    func add(_ journey: Journey) {
        journeys.append(journey)
    }
}

/// An individual journey
struct Journey {

    // MARK: Properties

    /// The entry station for this journey
    let entryStation: Station?

    /// The exit station for this journey
    var exitStation: Station?
}
