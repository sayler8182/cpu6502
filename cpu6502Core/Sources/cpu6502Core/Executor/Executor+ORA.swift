extension Executor {
    /// Logical Inclusive OR
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.ORA_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        cpu.registers.A = cpu.registers.A | data

        cpu.flags.setZero(cpu.registers.A)
        cpu.flags.setNegative(cpu.registers.A)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
