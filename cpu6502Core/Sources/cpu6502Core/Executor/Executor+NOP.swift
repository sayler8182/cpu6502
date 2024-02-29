extension Executor {
    /// Do nothing
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.NOP_OPCODE
    ) throws -> ExecutorResult {
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
