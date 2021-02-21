import XCTest
@testable import Osytercard

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

    func testDeductingCreditReducesTheBalance() throws {
        try card.topup(10.00)

        card.deduct(3.50)

        XCTAssertEqual(card.balance, 6.50)
    }

    func testTouchingInStartsTheJourney() throws {
        try card.topup(1)
        try card.touchIn()

        XCTAssertEqual(card.isInJourney, true)
    }

    func testTouchingOutStopsTheJourney() throws {
        card.touchOut()

        XCTAssertEqual(card.isInJourney, false)
    }

    func testTouchingInWithLessThanTheMinimumFareThrowsAnError() throws {
        XCTAssertThrowsError(try card.touchIn(), "Minimum fare required") { error in
            XCTAssertEqual(card.isInJourney, false)
            XCTAssertEqual(error as! OystercardError, OystercardError.balanceLowerThanMinimumFare)
        }
    }
}
