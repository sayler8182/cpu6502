extension Executor {
    /// Transfer Accumulator to Y
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TAY_OPCODE
    ) throws -> ExecutorResult {
        cpu.registers.Y = cpu.registers.A

        cpu.flags.Z = cpu.registers.Y == 0
        cpu.flags.N = (cpu.registers.Y & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
