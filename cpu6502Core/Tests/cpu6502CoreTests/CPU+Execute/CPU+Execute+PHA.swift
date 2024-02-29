import XCTest

@testable import cpu6502Core

final class CPUExecutePHATests: XCTestCase {
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

    func test_PHA_IMPL() throws {
        let opcode = CPU.Instruction.PHA_OPCODE.IMPL
        cpu.registers.A = 0xC7
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTStackPointer(sp: cpu.SP, in: memory, value: cpu.registers.A)
        XCTAssertEqual(cpu.SP, CPU.START_SP - 1);
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
