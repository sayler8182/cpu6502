extension Executor {
    /// Force Interrupt / Force Break
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.BRK_OPCODE
    ) throws -> ExecutorResult {
        try cpu.push(
            word: cpu.PC + 2,
            to: &memory)

        // loads also the break flag 
        cpu.flags.B = true

        try cpu.push(
            byte: cpu.flags.value,
            to: &memory)

        cpu.PC = cpu.address(
            of: 0xFFFE,
            from: memory)

        cpu.flags.I = true
        return (opcode.size, opcode.cycles, 0)
    }
}
