import XCTest

@testable import cpu6502Core

final class CPUExecutePLATests: XCTestCase {
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
        let opcode = CPU.Instruction.PLA_OPCODE.IMPL
        cpu.SP = CPU.START_SP - 1
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_SP_FIRST_PAGE] = 0b10001101

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10001101)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTAssertEqual(cpu.SP, CPU.START_SP);
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_PLA_IMPL_zero() throws {
        let opcode = CPU.Instruction.PLA_OPCODE.IMPL
        cpu.SP = CPU.START_SP - 1
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_SP_FIRST_PAGE - 1] = 0b00000000

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b00000000)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTAssertEqual(cpu.SP, CPU.START_SP);
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
