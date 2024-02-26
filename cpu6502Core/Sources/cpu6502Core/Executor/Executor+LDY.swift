extension Executor {
    /// Executes LDY instruction
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.LDY_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        cpu.registers.Y = data

        cpu.flags.setZero(cpu.registers.Y)
        cpu.flags.setNegative(cpu.registers.Y)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
