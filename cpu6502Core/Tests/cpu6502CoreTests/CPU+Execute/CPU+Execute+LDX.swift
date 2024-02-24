import XCTest

@testable import cpu6502Core

final class CPUExecuteLDXTests: XCTestCase {
    private var cpu: CPU!
    private var memory: Memory!

    override func setUp() {
        super.setUp()
        cpu = CPU()
        cpu.flags = .random
        memory = .random
        memory.reset()
    }

    override func tearDown() {
        super.setUp()
        cpu = nil
        memory = nil
    }

    func test_LDX_IM() throws {
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.IM.byte
        memory[CPU.START_PC + 1] = 0x84

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 2)

        XCTAssertEqual(cpu.registers.X, 0x84)
        XCTAssertEqual(cycles, 2)
        XCTFlags(on: [.N], off: [.Z], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ZP() throws {
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ZP.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 3)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 3)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ZPY() throws {
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ZPY.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ZPY_wraps() throws {
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ZPY.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0041] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ABS() throws {
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ABS.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ABSY() throws {
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ABSY.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0x37

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 4)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 4)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }

    func test_LDX_ABSY_cross() throws {
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = CPU.Instruction.LDX_OPCODE.ABSY.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0x37 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 5)

        XCTAssertEqual(cpu.registers.X, 0x37)
        XCTAssertEqual(cycles, 5)
        XCTFlags(off: [.Z, .N], basedOn: initFlags, in: cpu.flags)
    }
}
