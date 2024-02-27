import XCTest

@testable import cpu6502Core

final class CPUExecuteTXATests: XCTestCase {
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

    func test_TXA_IMPL() throws {
        let opcode = CPU.Instruction.TXA_OPCODE.IMPL
        cpu.registers.X = 0xD0
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.A, 0xD0)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.N, .Z], from: initFlags, to: cpu.flags)
    }
}
