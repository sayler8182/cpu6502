import XCTest

@testable import cpu6502Core

final class CPUExecutePLPTests: XCTestCase {
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

    func test_PLA_IMPL() throws {
        let opcode = CPU.Instruction.PLP_OPCODE.IMPL
        cpu.SP = CPU.START_SP - 1
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_SP_FIRST_PAGE] = 0b10101101

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        // break flag and bit 5 ignored
        var result: Byte = 0b10101101
        result = result & ~(CPU.StatusFlags.Flag.U.value | CPU.StatusFlags.Flag.B.value)
        let u = initFlags.value & CPU.StatusFlags.Flag.U.value
        let b = initFlags.value & CPU.StatusFlags.Flag.B.value
        result = result | u | b

        XCTAssertEqual(cpu.flags.value, result)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTAssertEqual(cpu.SP, CPU.START_SP);
    }
}
