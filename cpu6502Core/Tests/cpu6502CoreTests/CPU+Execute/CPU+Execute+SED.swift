import XCTest

@testable import cpu6502Core

final class CPUExecuteSEDTests: XCTestCase {
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

    func test_SED_IMPL() throws {
        let opcode = CPU.Instruction.SED_OPCODE.IMPL
        memory[CPU.START_PC] = opcode.byte

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .D, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.D], from: initFlags, to: cpu.flags)
    }
}
