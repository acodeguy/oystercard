import Foundation

// MARK: - FareCalculator

/// Calculates fares for travel
class FareCalculator {
    /// Returns the fare for the given `Journey`
    func fare(for journey: Journey) -> Double {
        guard journey.entryStation != nil,
              journey.exitStation != nil else {
            return 6.00
        }

        return 1.00
    }
}
