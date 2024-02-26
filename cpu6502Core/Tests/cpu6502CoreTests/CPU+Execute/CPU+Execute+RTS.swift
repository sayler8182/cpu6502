import XCTest

@testable import cpu6502Core

final class CPUExecuteRTSTests: XCTestCase {
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

    func test_RTS_IMPL() throws {
        let opcode = CPU.Instruction.RTS_OPCODE.IMPL
        cpu.SP = CPU.START_SP - 2
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_SP_FIRST_PAGE] = 0xAD
        memory[CPU.START_SP_FIRST_PAGE - 1] = 0xFF // 0xFFAD

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, equal: 0xFFAD + 1)
        XCTAssertEqual(cpu.SP, CPU.START_SP)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
