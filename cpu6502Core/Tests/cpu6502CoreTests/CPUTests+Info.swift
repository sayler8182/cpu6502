import XCTest

@testable import cpu6502Core

final class CPUInfoTests: XCTestCase {
    func testSupportedInstruction() throws {
        let cpu = CPU()
        let info = cpu.supportedInstructionInfo
        print(info)
        XCTAssertFalse(info.isEmpty)
    }
}
