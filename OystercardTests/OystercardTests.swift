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
        let station = Station(name: "Vauxhall")
        try card.touchIn(at: station)

        XCTAssertEqual(card.isInJourney, true)
    }

    func testTouchingOutStopsTheJourney() throws {
        card.touchOut()

        XCTAssertEqual(card.isInJourney, false)
    }

    func testTouchingInWithLessThanTheMinimumFareThrowsAnError() throws {
        let station = Station(name: "London Bridge")
        XCTAssertThrowsError(try card.touchIn(at: station), "Minimum fare required") { error in
            XCTAssertEqual(card.isInJourney, false)
            XCTAssertEqual(error as! OystercardError, OystercardError.balanceLowerThanMinimumFare)
        }
    }

    func testTouchingOutDeductsTheMinimumFare() throws {
        try card.topup(5.00)

        card.touchOut()

        XCTAssertEqual(card.balance, 4.00)
    }

    func testTouchingInRecordsTheEntryStation() throws {
        try card.topup(3.00)
        let station = Station(name: "Finsbury Park")
        try card.touchIn(at: station)

        XCTAssertEqual(card.entryStation?.name, station.name)
    }

    func testTouchingOutForgetsTheEntryStation() throws {
        try card.topup(3.00)
        let station = Station(name: "Finsbury Park")
        try card.touchIn(at: station)

        card.touchOut()

        XCTAssertNil(card.entryStation)
    }
}
