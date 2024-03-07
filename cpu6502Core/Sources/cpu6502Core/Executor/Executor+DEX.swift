extension Executor {
    /// Decrement X Register
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.DEX_OPCODE
    ) throws -> ExecutorResult {
        cpu.registers.X = cpu.registers.X &- (1)

        cpu.flags.Z = cpu.registers.X == 0
        cpu.flags.N = (cpu.registers.X & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
