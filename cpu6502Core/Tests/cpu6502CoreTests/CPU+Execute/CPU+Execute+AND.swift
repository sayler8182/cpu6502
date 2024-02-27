import XCTest

@testable import cpu6502Core

final class CPUExecuteANDTests: XCTestCase {
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

    func test_AND_IM() throws {
        let opcode = CPU.Instruction.AND_OPCODE.IM
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_IM_zero() throws {
        let opcode = CPU.Instruction.AND_OPCODE.IM
        cpu.registers.A = 0b00000000
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0b00000000

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0b00000000)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ZP() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ZP
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 3)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ZPX() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ZPX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ZPX_wraps() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ZPX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0041] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ABS() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ABS
        cpu.registers.A = 0b10010110
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ABSX() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ABSX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ABSX_cross() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ABSX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b10110100 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ABSY() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ABSY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_ABSY_cross() throws {
        let opcode = CPU.Instruction.AND_OPCODE.ABSY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b10110100 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_INDX() throws {
        let opcode = CPU.Instruction.AND_OPCODE.INDX
        cpu.registers.A = 0b10010110
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080 + 0x5] = 0x80
        memory[0x0080 + 0x5 + 1] = 0x44 // 0x4480
        memory[0x4480] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_INDY() throws {
        let opcode = CPU.Instruction.AND_OPCODE.INDY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }

    func test_AND_INDY_cross() throws {
        let opcode = CPU.Instruction.AND_OPCODE.INDY
        cpu.registers.A = 0b10010110
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0b10110100

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(cpu.registers.A, 0b10010100)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
