extension Executor {
    /// Set Carry Flag
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SEC_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.C = true

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
