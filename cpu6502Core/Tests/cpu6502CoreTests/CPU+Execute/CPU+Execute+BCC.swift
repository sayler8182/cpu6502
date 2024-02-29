import XCTest

@testable import cpu6502Core

final class CPUExecuteBCCTests: XCTestCase {
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

    func test_BCC_REL() throws {
        let opcode = CPU.Instruction.BCC_OPCODE.REL
        cpu.flags.C = true
        cpu.PC = 0x01FD
        memory[0x01FD] = opcode.byte
        memory[0x01FD + 1] = 0xDA

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, equal: 0x01FD + Word(opcode.size))
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_BCC_REL_carry_clear() throws {
        let opcode = CPU.Instruction.BCC_OPCODE.REL
        cpu.flags.C = false
        cpu.PC = 0x01DD
        memory[0x01DD] = opcode.byte
        memory[0x01DD + 1] = 0x03

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, equal: 0x01DD + Word(opcode.size) + 0x03)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }

    func test_BCC_REL_carry_clear_cross() throws {
        let opcode = CPU.Instruction.BCC_OPCODE.REL
        cpu.flags.C = false
        cpu.PC = 0x01FD
        memory[0x01FD] = opcode.byte
        memory[0x01FD + 1] = 0x0A

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, equal: 0x01FD + Word(opcode.size) + 0x0A)
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
