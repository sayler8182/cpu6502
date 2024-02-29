extension Executor {
    /// Transfer Stack Pointer to X
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TSX_OPCODE
    ) throws -> ExecutorResult {
        cpu.registers.X = cpu.SP

        cpu.flags.Z = cpu.registers.X == 0
        cpu.flags.N = (cpu.registers.X & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
