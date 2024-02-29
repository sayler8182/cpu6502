extension Executor {
    /// Store X Register
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.STX_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)

        try cpu.write(
            byte: cpu.registers.X,
            to: &memory,
            for: addressingMode)

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
