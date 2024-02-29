extension Executor {
    /// Clear Carry Flag
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.CLC_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.C = false

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
