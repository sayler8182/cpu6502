extension Executor {
    /// Transfer X to Stack Pointer
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TXS_OPCODE
    ) throws -> ExecutorResult {
        cpu.SP = cpu.registers.X

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
