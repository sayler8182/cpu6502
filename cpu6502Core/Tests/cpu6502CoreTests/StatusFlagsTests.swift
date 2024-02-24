import XCTest

@testable import cpu6502Core

final class StatusFlagsTests: XCTestCase {
    func testFlags() throws {
        // var statusFlags = StatusFlags()


        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
        0x7

        0x8
        0x9
        0xa
        0xb
        0xc
        0xd
        0xe
        0xf

        let a = 0x7
        print(a & 0b10000000)
        print(a & 0b00000001)
        let x |= a
    }
}
