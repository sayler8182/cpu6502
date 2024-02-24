extension Executor {
    /// Executes LDA instruction
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(cpu: inout CPU,
                 memory: inout Memory,
                 opcode: CPU.Instruction.LDA_OPCODE) throws -> Cycles {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, cycles) = try cpu.read(
            from: memory,
            for: addressingMode)
        cpu.registers.A = data
        cpu.flags.setZeroAndNegative(cpu.registers.A)
        cpu.moveProgramCounter(opcode.size)
        return cycles
    }
}
