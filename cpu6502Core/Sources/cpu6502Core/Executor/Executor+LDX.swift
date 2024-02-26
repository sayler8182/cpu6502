extension Executor {
    /// Executes LDX instruction
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.LDX_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        cpu.registers.X = data

        cpu.flags.setZero(cpu.registers.X)
        cpu.flags.setNegative(cpu.registers.X)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
