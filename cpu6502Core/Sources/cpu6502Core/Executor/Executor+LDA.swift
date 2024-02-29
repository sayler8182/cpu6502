extension Executor {
    /// Load value into the accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.LDA_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, additionalCycles) = try cpu.read(
            from: memory,
            for: addressingMode)

        cpu.registers.A = data

        cpu.flags.Z = cpu.registers.A == 0
        cpu.flags.N = (cpu.registers.A & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, additionalCycles)
    }
}
