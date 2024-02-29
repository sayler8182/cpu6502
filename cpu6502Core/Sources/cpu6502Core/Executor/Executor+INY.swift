extension Executor {
    /// Increment Y Register
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.INY_OPCODE
    ) throws -> ExecutorResult {
        cpu.registers.Y = cpu.registers.Y.addingWithOverflow(1)

        cpu.flags.Z = cpu.registers.Y == 0
        cpu.flags.N = (cpu.registers.Y & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
