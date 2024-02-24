import XCTest

@testable import cpu6502Core

final class CPUStatusFlagsTests: XCTestCase {
    func testFlags() throws {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.value, 0x0)
        statusFlags = CPU.StatusFlags(0xa)
        XCTAssertEqual(statusFlags.value, 0xa)
    }

    func testN() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.N, false)

        statusFlags.value = 0b10000000
        XCTAssertEqual(statusFlags.N, true)
        statusFlags.value = 0b01111111
        XCTAssertEqual(statusFlags.N, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.N, true)
        statusFlags.N = false
        XCTAssertEqual(statusFlags.value, 0b01111111)
        statusFlags.N = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.N], 0b10000000)
    }

    func testV() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.V, false)

        statusFlags.value = 0b01000000
        XCTAssertEqual(statusFlags.V, true)
        statusFlags.value = 0b10111111
        XCTAssertEqual(statusFlags.V, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.V, true)
        statusFlags.V = false
        XCTAssertEqual(statusFlags.value, 0b10111111)
        statusFlags.V = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.V], 0b01000000)
    }

    func testB() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.B, false)

        statusFlags.value = 0b00010000
        XCTAssertEqual(statusFlags.B, true)
        statusFlags.value = 0b11101111
        XCTAssertEqual(statusFlags.B, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.B, true)
        statusFlags.B = false
        XCTAssertEqual(statusFlags.value, 0b11101111)
        statusFlags.B = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.B], 0b00010000)
    }

    func testD() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.D, false)

        statusFlags.value = 0b00001000
        XCTAssertEqual(statusFlags.D, true)
        statusFlags.value = 0b11110111
        XCTAssertEqual(statusFlags.D, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.D, true)
        statusFlags.D = false
        XCTAssertEqual(statusFlags.value, 0b11110111)
        statusFlags.D = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.D], 0b00001000)
    }

    func testI() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.I, false)

        statusFlags.value = 0b00000100
        XCTAssertEqual(statusFlags.I, true)
        statusFlags.value = 0b11111011
        XCTAssertEqual(statusFlags.I, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.I, true)
        statusFlags.I = false
        XCTAssertEqual(statusFlags.value, 0b11111011)
        statusFlags.I = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.I], 0b00000100)
    }

    func testZ() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.Z, false)

        statusFlags.value = 0b00000010
        XCTAssertEqual(statusFlags.Z, true)
        statusFlags.value = 0b11111101
        XCTAssertEqual(statusFlags.Z, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.Z, true)
        statusFlags.Z = false
        XCTAssertEqual(statusFlags.value, 0b11111101)
        statusFlags.Z = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.Z], 0b00000010)
    }

    func testC() {
        var statusFlags = CPU.StatusFlags(0x0)
        XCTAssertEqual(statusFlags.C, false)

        statusFlags.value = 0b00000001
        XCTAssertEqual(statusFlags.C, true)
        statusFlags.value = 0b11111110
        XCTAssertEqual(statusFlags.C, false)

        statusFlags.value = 0b11111111
        XCTAssertEqual(statusFlags.C, true)
        statusFlags.C = false
        XCTAssertEqual(statusFlags.value, 0b11111110)
        statusFlags.C = true
        XCTAssertEqual(statusFlags.value, 0b11111111)

        XCTAssertEqual(statusFlags[.C], 0b00000001)
    }
}
