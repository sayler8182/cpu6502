extension Executor {
    /// Pull Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PLA_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let data: Byte = try cpu.pull(from: &memory)
        cpu.registers.A = data

        cpu.flags.setZero(cpu.registers.A)
        cpu.flags.setNegative(cpu.registers.A)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
