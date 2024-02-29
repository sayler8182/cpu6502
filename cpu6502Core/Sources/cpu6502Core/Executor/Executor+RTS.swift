extension Executor {
    /// Return from Subroutine
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.RTS_OPCODE
    ) throws -> ExecutorResult {
        let word: Word = try cpu.pull(from: &memory)
        cpu.PC = word + 1

        return (opcode.size, opcode.cycles, 0)
    }
}
