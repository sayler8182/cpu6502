extension Executor {
    /// Subtract with Carry
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SBC_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        let cBit: Byte = cpu.flags.C ? 0b1 : 0b0
        assert(!cpu.flags.D, "Decimal mode not handled" )

        let base = cpu.registers.A
        let result = base
            .subtractingWithOverflow(data)
            .subtractingWithOverflow(1 - cBit)
        cpu.registers.A = result

        cpu.flags.C = (data & 0b10000000) != 0
        cpu.flags.setZero(result)
        cpu.flags.V = ((base ^ data) & (base ^ result) & 0x80) > 0
        cpu.flags.setNegative(result)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
