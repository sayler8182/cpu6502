import XCTest

@testable import cpu6502Core

final class CPUExecuteINYTests: XCTestCase {
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

    func test_INY_IMPL() throws {
        let opcode = CPU.Instruction.INY_OPCODE.IMPL
        cpu.registers.Y = 0x37
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.Y, 0x38)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_INY_IMPL_overflow() throws {
        let opcode = CPU.Instruction.INY_OPCODE.IMPL
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.Y, 0x00)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
