import XCTest

@testable import cpu6502Core

final class CPUExecuteORATests: XCTestCase {
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

    func test_ORA_IM() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.IM
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_IM_zero() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.IM
        cpu.registers.A = 0b00000000
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b00000000

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b00000000)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ZP() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ZP
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 3)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ZPX() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ZPX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ZPX_wraps() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ZPX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0041] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ABS() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ABS
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ABSX() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ABSX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ABSX_cross() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ABSX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b00110100 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ABSY() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ABSY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_ABSY_cross() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.ABSY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b00110100 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_INDX() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.INDX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080 + 0x5] = 0x80
        memory[0x0080 + 0x5 + 1] = 0x44 // 0x4480
        memory[0x4480] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_INDY() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.INDY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_ORA_INDY_cross() throws {
        let opcode = CPU.Instruction.ORA_OPCODE.INDY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b00110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(cpu.registers.A, 0b10110110)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(cpu.PC, opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
