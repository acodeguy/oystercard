import XCTest
@testable import Osytercard

class OystercardTests: XCTestCase {

    // MARK: Properties

    private var card: Oystercard!

    // MARK: Test lifecycle methods

    override func setUpWithError() throws {
        try super.setUpWithError()

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
        }
    }

    func testDeductingCreditReducesTheBalance() throws {
        try card.topup(10.00)

        card.deduct(3.50)

        XCTAssertEqual(card.balance, 6.50)
    }
}
