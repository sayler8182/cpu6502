extension Executor {
    /// Set Interrupt Disable
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SEI_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.I = true

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
