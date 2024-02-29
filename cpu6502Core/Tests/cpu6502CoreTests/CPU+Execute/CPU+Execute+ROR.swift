import XCTest

@testable import cpu6502Core

final class CPUExecuteRORTests: XCTestCase {
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

    func test_ROR_ACC() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ACC
        cpu.flags.C = false
        cpu.registers.A = 0b10000110
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0b01000011)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ROR_ACC_carry() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ACC
        cpu.flags.C = true
        cpu.registers.A = 0b01000111
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0b10100011)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ROR_ZP() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ZP
        cpu.flags.C = false
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x0042], 0b01000011)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ROR_ZPX() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ZPX
        cpu.flags.C = false
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x0042 + 0x5], 0b01000011)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ROR_ABS() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ABS
        cpu.flags.C = false
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x4480], 0b01000011)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ROR_ABSX() throws {
        let opcode = CPU.Instruction.ROR_OPCODE.ABSX
        cpu.flags.C = false
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b10000111

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x4480 + 0x5], 0b01000011)
        XCTAssertEqual(cycles, 7)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z], from: initFlags, to: cpu.flags)
    }
}
