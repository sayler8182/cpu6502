extension Executor {
    /// Clear Interrupt Disable
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.CLI_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.I = false

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
