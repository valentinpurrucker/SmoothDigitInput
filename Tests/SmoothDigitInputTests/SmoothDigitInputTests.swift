import XCTest
@testable import SmoothDigitInput

final class SmoothDigitInputTests: XCTestCase {
    func testAddDigitValid() throws {
        let digitStore = DigitStore()

        XCTAssertTrue(digitStore.add(5))
    }

    func testAddDecimalInvalid() throws {
        let digitStore = DigitStore()

        XCTAssertFalse(digitStore.addDecimal())
    }

    func testCheckForDecimalValid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(5)
        _ = digitStore.addDecimal()

        XCTAssertTrue(digitStore.hasDecimal())
    }

    func testCheckForDecimalInvalid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(5)

        XCTAssertFalse(digitStore.hasDecimal())
    }

    func testCheckNumberValid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(5)
        
        XCTAssertEqual(digitStore.getNumber(), 5)
    }

    func testCheckGroupingNumberValid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(5)
        _ = digitStore.add(5)
        _ = digitStore.add(5)
        _ = digitStore.add(5)

        XCTAssertEqual(digitStore.getNumber(), 5555)
    }

    func testCheckGroupingValid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(1)
        _ = digitStore.add(0)
        _ = digitStore.add(0)
        _ = digitStore.add(0)

        XCTAssertEqual(digitStore.inputEntries.count, 5)
    }

    func testCheckGroupingBigNumberValid() throws {
        let digitStore = DigitStore()

        _ = digitStore.add(1)
        _ = digitStore.add(0)
        _ = digitStore.add(0)
        _ = digitStore.add(0)
        _ = digitStore.add(0)
        _ = digitStore.add(0)

        XCTAssertEqual(digitStore.inputEntries.count, 7)
    }
}
