import XCTest

@testable import cpu6502Core

final class CPUExecuteLDYTests: XCTestCase {
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

    func test_LDY_IM() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.IM
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x84

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.Y, 0x84)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ZP() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ZP
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 3)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ZPX() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ZPX
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ZPX_wraps() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ZPX
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0041] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ABS() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ABS
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ABSX() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ABSX
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_LDY_ABSX_cross() throws {
        let opcode = CPU.Instruction.LDY_OPCODE.ABSX
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0x37 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.Y, 0x37)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
