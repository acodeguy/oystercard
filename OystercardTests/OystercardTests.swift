import XCTest
@testable import Oystercard

class OystercardTests: XCTestCase {

    // MARK: Properties

    private var card: Oystercard!

    // MARK: Test lifecycle methods

    override func setUpWithError() throws {
        try super.setUpWithError()

        continueAfterFailure = true

        card = Oystercard()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        card = nil
    }

    // MARK: Test cases

    func testToppingUpFundsIncreasesTheBalanceByTheCorrectAmount() throws {
        try card.topup(5.50)

        XCTAssertEqual(card.balance, 5.50)
    }

    func testToppingUpFundsFailsIfBalanceWouldBeGreaterThanTheMaximumAllowed() throws {
        XCTAssertThrowsError(try card.topup(90.01), "Balance would exceed maximum allowed") { error in
            XCTAssertEqual(card.balance, 0)
            XCTAssertEqual(error as! OystercardError, OystercardError.maximumBalanceExceeded)
        }
    }

    func testTouchingInStartsTheJourney() throws {
        try card.topup(1)
        let station = try Station(name: "Vauxhall", zone: 2)
        try card.touchIn(at: station)

        XCTAssertEqual(card.isInJourney, true)
    }

    func testTouchingOutStopsTheJourney() throws {
        let exitStation = try Station(name: "xyz456", zone: 1)
        card.touchOut(at: exitStation)

        XCTAssertEqual(card.isInJourney, false)
    }

    func testTouchingInWithLessThanTheMinimumFareThrowsAnError() throws {
        let station = try Station(name: "London Bridge", zone: 1)
        XCTAssertThrowsError(try card.touchIn(at: station), "Minimum fare required") { error in
            XCTAssertEqual(card.isInJourney, false)
            XCTAssertEqual(error as! OystercardError, OystercardError.balanceLowerThanMinimumFare)
        }
    }

    func testTouchingOutDeductsTheMinimumFare() throws {
        try card.topup(5.00)

        let exitStation = try Station(name: "abc123", zone: 1)
        card.touchOut(at: exitStation)

        XCTAssertEqual(card.balance, 4.00)
    }

    func testTouchingInRecordsTheEntryStation() throws {
        try card.topup(3.00)
        let station = try Station(name: "Finsbury Park", zone: 2)
        try card.touchIn(at: station)

        XCTAssertEqual(card.entryStation?.name, station.name)
    }

    func testTouchingOutForgetsTheEntryStation() throws {
        try card.topup(3.00)
        let station = try Station(name: "Finsbury Park", zone: 2)
        try card.touchIn(at: station)

        let exitStation = try Station(name: "jkl789", zone: 4)
        card.touchOut(at: exitStation)

        XCTAssertNil(card.entryStation)
    }

    func testCompletingAJourneyAddsItToTheJourneyHistory() throws {
        XCTAssertEqual(card.journeyHistory?.journeys.count, 0)
        try card.topup(3.00)
        let entryStation = try Station(name: "Finsbury Park", zone: 2)
        try card.touchIn(at: entryStation)

        let exitStation = try Station(name: "Pimlico", zone: 2)
        card.touchOut(at: exitStation)

        let journey = try XCTUnwrap(card.journeyHistory?.journeys.first)
        XCTAssertEqual(journey.entryStation?.name, entryStation.name)
        XCTAssertEqual(journey.exitStation?.name, exitStation.name)

        // set the touch-in/out stations back to nil
        XCTAssertEqual(card.entryStation, nil)
        XCTAssertEqual(card.exitStation, nil)
    }
}
