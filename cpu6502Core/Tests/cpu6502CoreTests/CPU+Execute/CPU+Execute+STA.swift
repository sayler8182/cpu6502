import XCTest

@testable import cpu6502Core

final class CPUExecuteSTATests: XCTestCase {
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

    func test_STA_ZP() throws {
        let opcode = CPU.Instruction.STA_OPCODE.ZP
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 3)

        XCTAssertEqual(memory[0x0042], 0xD0)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_ZPX() throws {
        let opcode = CPU.Instruction.STA_OPCODE.ZPX
        cpu.registers.A = 0xD0
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(memory[0x0042 + 0x5], 0xD0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_ABS() throws {
        let opcode = CPU.Instruction.STA_OPCODE.ABS
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(memory[0x4480], 0xD0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_ABSX() throws {
        let opcode = CPU.Instruction.STA_OPCODE.ABSX
        cpu.registers.A = 0xD0
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(memory[0x4480 + 0xFF], 0xD0)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_ABSY() throws {
        let opcode = CPU.Instruction.STA_OPCODE.ABSY
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(memory[0x4480 + 0xFF], 0xD0)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_INDX() throws {
        let opcode = CPU.Instruction.STA_OPCODE.INDX
        cpu.registers.A = 0xD0
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080 + 0x5] = 0x80
        memory[0x0080 + 0x5 + 1] = 0x44 // 0x4480
        memory[0x4480] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(memory[0x4480], 0xD0)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STA_INDY() throws {
        let opcode = CPU.Instruction.STA_OPCODE.INDY
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 6)

        XCTAssertEqual(memory[0x4480 + 0xFF], 0xD0)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
