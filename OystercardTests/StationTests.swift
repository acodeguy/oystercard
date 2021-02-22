import XCTest
@testable import Oystercard

class StationTests: XCTest {

    func testIsCreatedWithANameAndAZone() throws {
        let station = try Station(name: "Finsbury Park", zone: 2)

        XCTAssertEqual(station.name, "Finsbury Park")
        XCTAssertEqual(station.zone, 2)
    }
}
