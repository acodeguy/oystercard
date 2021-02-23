import XCTest
@testable import Oystercard

class FareCalculatorTests: XCTestCase {
    func testReturnssTheMinimumFareForACompleteJourney() throws {
        let entryStation = try Station(name: "Vauxhall", zone: 2)
        let exitStation = try Station(name: "Walthamstow Central", zone: 3)
        let journey = Journey(entryStation: entryStation, exitStation: exitStation)
        let fareCalculator = FareCalculator()

        let fare = fareCalculator.fare(for: journey)

        XCTAssertEqual(fare, 1.00)
    }

    func testReturnsThePenaltyFareWhenTheEntryStationIsMissing() throws {
        let entryStation = try Station(name: "Vauxhall", zone: 2)
        let journey = Journey(entryStation: entryStation, exitStation: nil)
        let fareCalculator = FareCalculator()

        let fare = fareCalculator.fare(for: journey)

        XCTAssertEqual(fare, 6.00)
    }

    func testReturnsThePenaltyFareWhenTheExitStationIsMissing() throws {
        let exitStation = try Station(name: "Green Park", zone: 1)
        let journey = Journey(entryStation: exitStation, exitStation: nil)
        let fareCalculator = FareCalculator()

        let fare = fareCalculator.fare(for: journey)

        XCTAssertEqual(fare, 6.00)
    }
}

