import Foundation

// MARK: - Station

/// A station on the TfL network
struct Station {

    // MARK: Properties

    /// The name is this TfL station
    let name: String

    /// The zone in which this station is
    let zone: Int

    // MARK: Lifecycle methods

    init(name: String, zone: Int) throws {
        self.name = name
        self.zone = zone

        if zone < 1 || zone > 9 {
            assertionFailure("Zones must be within the range of 1 through 9")
        }
    }
}

// MARK: - Hashable

extension Station: Hashable {}
