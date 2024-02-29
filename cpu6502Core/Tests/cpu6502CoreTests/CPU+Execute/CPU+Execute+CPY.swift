import XCTest

@testable import cpu6502Core

final class CPUExecuteCPYTests: XCTestCase {
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

    func test_CPY_IM() throws {
        let opcode = CPU.Instruction.CPY_OPCODE.IM
        cpu.registers.Y = 0b11100011
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b11000011

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_CPY_IM_zero() throws {
        let opcode = CPU.Instruction.CPY_OPCODE.IM
        cpu.registers.Y = 0b11100011
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b11100011

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_CPY_ZP() throws {
        let opcode = CPU.Instruction.CPY_OPCODE.ZP
        cpu.registers.Y = 0b11100011
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0b01100011

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_CPY_ABS() throws {
        let opcode = CPU.Instruction.CPY_OPCODE.ABS
        cpu.registers.Y = 0b11100011
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0b11000011

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }
}
