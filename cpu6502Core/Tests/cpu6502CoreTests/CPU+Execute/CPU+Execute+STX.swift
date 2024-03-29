import XCTest

@testable import cpu6502Core

final class CPUExecuteSTXTests: XCTestCase {
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

    func test_STX_ZP() throws {
        let opcode = CPU.Instruction.STX_OPCODE.ZP
        cpu.registers.X = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x0042], 0xD0)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STX_ZPY() throws {
        let opcode = CPU.Instruction.STX_OPCODE.ZPY
        cpu.registers.X = 0xD0
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x0042 + 0x5], 0xD0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_STX_ABS() throws {
        let opcode = CPU.Instruction.STX_OPCODE.ABS
        cpu.registers.X = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0x00

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(memory[0x4480], 0xD0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
