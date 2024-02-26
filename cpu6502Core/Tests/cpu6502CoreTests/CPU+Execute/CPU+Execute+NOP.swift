import XCTest

@testable import cpu6502Core

final class CPUExecuteNOPTests: XCTestCase {
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

    func test_NOP_IMPL() throws {
        let opcode = CPU.Instruction.NOP_OPCODE.IMPL
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
