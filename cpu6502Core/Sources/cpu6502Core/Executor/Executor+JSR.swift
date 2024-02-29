extension Executor {
    /// Jump to Subroutine
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.JSR_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let address = try cpu.address(
            from: memory,
            for: addressingMode)

        try cpu.push(
            word: cpu.PC + Word(opcode.size - 1),
            to: &memory)
        cpu.PC = address

        return (opcode.size, opcode.cycles, 0)
    }
}
