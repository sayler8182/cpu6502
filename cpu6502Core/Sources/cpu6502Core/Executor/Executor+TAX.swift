extension Executor {
    /// Transfer Accumulator to X
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TAX_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.registers.X = cpu.registers.A

        cpu.flags.setZero(cpu.registers.X)
        cpu.flags.setNegative(cpu.registers.X)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
