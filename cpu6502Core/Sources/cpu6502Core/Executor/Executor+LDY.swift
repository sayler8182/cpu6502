extension Executor {
    /// Executes LDY instruction
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(cpu: inout CPU,
                 memory: inout Memory,
                 opcode: CPU.Instruction.LDY_OPCODE) throws -> Cycles {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, cycles) = try cpu.read(
            from: memory,
            for: addressingMode)
        cpu.registers.Y = data
        cpu.flags.setZeroAndNegative(cpu.registers.Y)
        cpu.moveProgramCounter(opcode.size)
        return cycles
    }
}
