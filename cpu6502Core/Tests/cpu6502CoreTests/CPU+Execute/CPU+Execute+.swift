import XCTest

@testable import cpu6502Core

extension XCTestCase {
    /// Verifies if the flags are correctly set
    /// - flags: Flags that should be set to '0'
    /// - basedOn oldFlags: old cpu flags
    /// - in newFlags: new cpu flags
    func XCTFlags(on onFlags: [CPU.StatusFlags.Flag] = [],
                  off offFlags: [CPU.StatusFlags.Flag] = [],
                  basedOn oldFlags: CPU.StatusFlags,
                  in newFlags: CPU.StatusFlags,
                  file: StaticString = #filePath,
                  line: UInt = #line) {
        for flag: Byte in (0...0x7) {
            if onFlags.contains(where: { $0.rawValue == flag }) {
                // the specific flag should not be set
                XCTAssertTrue(
                    ((newFlags.value & (1 << flag)) >> flag) == 1,
                    "Flag \(CPU.StatusFlags.Flag(rawValue: flag)!) should be '1' instead of '0'",
                    file: file,
                    line: line)
                continue
            }

            if offFlags.contains(where: { $0.rawValue == flag }) {
                // the specific flag should not be set
                XCTAssertTrue(
                    ((newFlags.value & (1 << flag)) >> flag) == 0,
                    "Flag \(CPU.StatusFlags.Flag(rawValue: flag)!) should be '0' instead of '1'",
                    file: file,
                    line: line)
                continue
            }

            // the specific flag should be unchanged
            XCTAssertEqual(
                oldFlags.value & (1 << flag),
                newFlags.value & (1 << flag),
                    """
                    Flag \(CPU.StatusFlags.Flag(rawValue: flag)!) shouldn't changed
                    (is '\((newFlags.value & (1 << flag)) >> flag)' instead of '\((oldFlags.value & (1 << flag)) >> flag)'
                    """,
                file: file,
                line: line)
        }
    }
}
