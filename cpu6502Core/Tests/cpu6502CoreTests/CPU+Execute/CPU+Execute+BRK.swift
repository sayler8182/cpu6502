import XCTest

@testable import cpu6502Core

final class CPUExecuteBRKTests: XCTestCase {
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

    func test_BRK_IMPL() throws {
        let opcode = CPU.Instruction.BRK_OPCODE.IMPL
        cpu.PC = 0x01FD
        memory[0x01FD] = opcode.byte
        memory[0xFFFE] = 0x80
        memory[0xFFFF] = 0x44 // 0x4480
        memory[0x4480] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cycles, 7)
        XCTProgramCounter(pc: cpu.PC, equal: 0x4480)
        XCTStackPointer(sp: cpu.SP, offset: 1, in: memory, value: initFlags.value | CPU.StatusFlags.Flag.B.value)
        XCTStackPointer(sp: cpu.SP, offset: 2, in: memory, value: 0xFF)
        XCTStackPointer(sp: cpu.SP, offset: 3, in: memory, value: 0x01)
        XCTFlagTrue(flag: .B, in: cpu.flags)
        XCTFlagTrue(flag: .I, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.B, .I], from: initFlags, to: cpu.flags)
    }
}
