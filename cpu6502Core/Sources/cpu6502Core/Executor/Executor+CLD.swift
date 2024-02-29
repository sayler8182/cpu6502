extension Executor {
    /// Clear Decimal Mode
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.CLD_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.D = false

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
