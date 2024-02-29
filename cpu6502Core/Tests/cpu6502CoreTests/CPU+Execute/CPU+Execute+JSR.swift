import XCTest

@testable import cpu6502Core

final class CPUExecuteJSRTests: XCTestCase {
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

    func test_JSR_ABS() throws {
        let opcode = CPU.Instruction.JSR_OPCODE.ABS
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, equal: 0x4480)
        XCTStackPointer(sp: cpu.SP, offset: 1, in: memory, value: 0xFE)
        XCTStackPointer(sp: cpu.SP, offset: 2, in: memory, value: 0xFF)
        XCTAssertEqual(cpu.SP, CPU.START_SP - 2);
        XCTFlagsUnchanged(from: initFlags, to: cpu.flags)
    }
}
