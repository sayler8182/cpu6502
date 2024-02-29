import XCTest

@testable import cpu6502Core

final class CPUExecuteJMPTests: XCTestCase {
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

    func test_JMP_ABS() throws {
        let opcode = CPU.Instruction.JMP_OPCODE.ABS
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, equal: 0x4480)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_JMP_ABS_IND() throws {
        let opcode = CPU.Instruction.JMP_OPCODE.IND
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, equal: 0x4480)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
