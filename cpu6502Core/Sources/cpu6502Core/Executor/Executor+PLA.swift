extension Executor {
    /// Pull Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PLA_OPCODE
    ) throws -> ExecutorResult {
        let data: Byte = try cpu.pull(from: &memory)
        cpu.registers.A = data

        cpu.flags.Z = cpu.registers.A == 0
        cpu.flags.N = (cpu.registers.A & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
