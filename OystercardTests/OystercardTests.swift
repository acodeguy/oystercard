import XCTest
@testable import Osytercard

class OystercardTests: XCTestCase {

    func testToppingUpFundsIncreasesTheBalanceByTheCorrectAmount() {
        let card = Oystercard()

        card.topup(5.50)

        XCTAssertEqual(card.balance, 5.50)
    }
}
