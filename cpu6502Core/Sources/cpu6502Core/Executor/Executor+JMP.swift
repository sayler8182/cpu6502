extension Executor {
    /// Jump
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.JMP_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let address = try cpu.address(
            from: memory,
            for: addressingMode)

        cpu.PC = address

        return (opcode.size, opcode.cycles, 0)
    }
}
