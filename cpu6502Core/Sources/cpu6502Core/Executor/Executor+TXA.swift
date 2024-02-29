extension Executor {
    /// Transfer X to Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TXA_OPCODE
    ) throws -> ExecutorResult {
        cpu.registers.A = cpu.registers.X

        cpu.flags.Z = cpu.registers.A == 0
        cpu.flags.N = (cpu.registers.A & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
