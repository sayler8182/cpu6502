extension Executor {
    /// Executes LDX instruction
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(cpu: inout CPU,
                 memory: inout Memory,
                 opcode: CPU.Instruction.LDX_OPCODE) throws -> Cycles {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, cycles) = try cpu.read(
            from: memory,
            for: addressingMode)
        cpu.registers.X = data
        cpu.flags.setZeroAndNegative(cpu.registers.X)
        cpu.moveProgramCounter(opcode.size)
        return cycles
    }
}
