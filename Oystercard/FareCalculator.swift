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

        let minmumFare = 1.00

        guard let entryZone = journey.entryStation?.zone,
              let exitZone = journey.exitStation?.zone else {
            return minmumFare
        }

        let zonesCrossed = entryZone.distance(to: exitZone)

        return minmumFare + Double(zonesCrossed)
    }
}
