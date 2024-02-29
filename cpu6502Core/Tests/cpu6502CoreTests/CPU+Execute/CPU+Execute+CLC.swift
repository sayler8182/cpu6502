import XCTest

@testable import cpu6502Core

final class CPUExecuteCLCTests: XCTestCase {
    private var cpu: CPU!
    private var memory: Memory!

    override func setUp() {
        super.setUp()
        cpu = CPU()
        cpu.registers = .random
        cpu.flags = .random
        memory = .random
        memory.reset()
    }

    override func tearDown() {
        super.setUp()
        cpu = nil
        memory = nil
    }

    func test_CLC_IMPL() throws {
        let opcode = CPU.Instruction.CLC_OPCODE.IMPL
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C], from: initFlags, to: cpu.flags)
    }
}
