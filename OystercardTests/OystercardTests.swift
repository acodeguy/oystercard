import XCTest
@testable import Osytercard

class OystercardTests: XCTestCase {

    func testToppingUpFundsIncreasesTheBalanceByTheCorrectAmount() throws {
        let card = Oystercard()

        try card.topup(5.50)

        XCTAssertEqual(card.balance, 5.50)
    }

    func testToppingUpFundsFailsIfBalanceWouldBeGreaterThanTheMaximumAllowed() throws {
        let card = Oystercard()

        XCTAssertThrowsError(try card.topup(90.01), "Balance would exceed maximum allowed") { error in
            XCTAssertEqual(card.balance, 0)
        }
    }
}
