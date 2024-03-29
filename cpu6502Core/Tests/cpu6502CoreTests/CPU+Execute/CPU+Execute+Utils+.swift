import XCTest

@testable import cpu6502Core

extension XCTestCase {
    /// Verifies if the Program Counter is correctly set
    /// - pc: Program Counter
    /// - equal value: correct Program Counter
    func XCTProgramCounter(pc: Word,
                           equal value: Word,
                           file: StaticString = #filePath,
                           line: UInt = #line) {
        XCTAssertEqual(
            pc,
            value,
            "Program counter is \(pc.hex) instead of \(value.hex)",
            file: file,
            line: line
        )
    }

    /// Verifies if the Program Counter is correctly set
    /// - pc: Program Counter
    /// - size: executed OPCODE size
    func XCTProgramCounter(pc: Word,
                           size: Byte,
                           file: StaticString = #filePath,
                           line: UInt = #line) {
        let result = CPU.START_PC + Word(size)
        XCTAssertEqual(
            pc,
            result,
            "Program counter is \(pc.hex) instead of \(result.hex)",
            file: file,
            line: line
        )
    }

    /// Verifies if the Stack Pointer is correctly set
    /// - sp: Stack Pointer
    /// - memory: program memory
    func XCTStackPointer(sp: Byte,
                         offset: Byte = 1,
                         in memory: Memory,
                         value: Byte,
                         file: StaticString = #filePath,
                         line: UInt = #line) {
        let sp = (Word(sp) | 0x0100) + Word(offset)
        XCTAssertEqual(
            memory[sp],
            value,
            "Stack Pointer is incorrectly set \(memory[sp].hex) instead of \(value.hex)",
            file: file,
            line: line
        )
    }

    /// Verifies if the flags are correctly set
    /// - flags: Flags that should be set to '0'
    /// - from oldFlags: old cpu flags
    /// - to newFlags: new cpu flags
    func XCTFlagsUnchanged(skip: [CPU.StatusFlags.Flag] = [],
                           from oldFlags: CPU.StatusFlags,
                           to newFlags: CPU.StatusFlags,
                           file: StaticString = #filePath,
                           line: UInt = #line) {
        for flag: Byte in (0...0x7) {
            if skip.contains(where: { $0.rawValue == flag }) {
                // the specific flag should be skipped
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
                line: line
            )
        }
    }

    /// Verifies if the flag is correctly set
    /// - flag: Flag that should be set to '0'
    /// - in flags: new cpu flags
    func XCTFlagFalse(flag: CPU.StatusFlags.Flag,
                      in flags: CPU.StatusFlags,
                      file: StaticString = #filePath,
                      line: UInt = #line) {
        // the specific flag should not be set
        XCTAssertTrue(
            (flags.value & (1 << flag.rawValue)) == 0,
            "Flag \(flag) should be '0' instead of '1'",
            file: file,
            line: line
        )
    }

    /// Verifies if the flag is correctly set
    /// - flag: Flag that should be set to '1'
    /// - in flags: new cpu flags
    func XCTFlagTrue(flag: CPU.StatusFlags.Flag,
                     in flags: CPU.StatusFlags,
                     file: StaticString = #filePath,
                     line: UInt = #line) {
        // the specific flag should be set
        XCTAssertTrue(
            (flags.value & (1 << flag.rawValue)) != 0,
            "Flag \(flag) should be '1' instead of '0'",
            file: file,
            line: line
        )
    }
}
