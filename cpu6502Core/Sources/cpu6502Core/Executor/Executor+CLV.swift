extension Executor {
    /// Clear Overflow Flag
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.CLV_OPCODE
    ) throws -> ExecutorResult {
        cpu.flags.V = false

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
