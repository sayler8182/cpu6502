import XCTest

@testable import cpu6502Core

final class CPUExecuteLSRTests: XCTestCase {
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

    func test_LSR_ACC() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ACC
        cpu.registers.A = 0b00000110
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b00000011)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LSR_ACC_carry() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ACC
        cpu.registers.A = 0b10000111
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b01000011)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LSR_ZP() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ZP
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(memory[0x0042], 0b01000011)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LSR_ZPX() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ZPX
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(memory[0x0042 + 0x5], 0b01000011)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LSR_ABS() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ABS
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(memory[0x4480], 0b01000011)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LSR_ABSX() throws {
        let opcode = CPU.Instruction.LSR_OPCODE.ABSX
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(memory[0x4480 + 0x5], 0b01000011)
        XCTAssertEqual(cycles, 7)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }
}
