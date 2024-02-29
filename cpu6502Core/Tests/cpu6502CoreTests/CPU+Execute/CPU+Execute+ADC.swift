import XCTest

@testable import cpu6502Core

final class CPUExecuteADCTests: XCTestCase {
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


    func test_ADC_IM_1() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0x50
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x10

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0x60)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_2() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0x50
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x50

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_3() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0x50
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x90

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xE0)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_4() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0x50
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0x20)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_5() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x10

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xE0)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagFalse(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_6() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x50

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0x20)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_7() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x90

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0x60)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagFalse(flag: .N, in: cpu.flags)
        XCTFlagTrue(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_IM_8() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.IM
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 2)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ZP() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ZP
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 3)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ZPX() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ZPX
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0042 + 0x5] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ZPX_wraps() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ZPX
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x42
        memory[0x0041] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ABS() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ABS
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ABSX() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ABSX
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ABSX_cross() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ABSX
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.X = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0xD0 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ABSY() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ABSY
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 4)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_ABSY_cross() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.ABSY
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[CPU.START_PC + 2] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0xD0 // crossing page

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_INDX() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.INDX
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.X = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080 + 0x5] = 0x80
        memory[0x0080 + 0x5 + 1] = 0x44 // 0x4480
        memory[0x4480] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_INDY() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.INDY
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0x5
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0x5] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 5)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }

    func test_ADC_INDY_cross() throws {
        let opcode = CPU.Instruction.ADC_OPCODE.INDY
        cpu.flags.D = false
        cpu.flags.C = false
        cpu.registers.A = 0xD0
        cpu.registers.Y = 0xFF
        memory[CPU.START_PC] = opcode.byte
        memory[CPU.START_PC + 1] = 0x80
        memory[0x0080] = 0x80
        memory[0x0080 + 1] = 0x44 // 0x4480
        memory[0x4480 + 0xFF] = 0xD0

        let initFlags = cpu.flags
        let cycles = try cpu.execute(
            memory: &memory,
            cycles: 1)

        XCTAssertEqual(cpu.registers.A, 0xA0)
        XCTAssertEqual(cycles, 6)
        XCTProgramCounter(pc: cpu.PC, size: opcode.size)
        XCTFlagTrue(flag: .C, in: cpu.flags)
        XCTFlagTrue(flag: .N, in: cpu.flags)
        XCTFlagFalse(flag: .V, in: cpu.flags)
        XCTFlagFalse(flag: .Z, in: cpu.flags)
        XCTFlagsUnchanged(skip: [.C, .N, .Z, .V], from: initFlags, to: cpu.flags)
    }
}
