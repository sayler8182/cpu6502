extension Executor {
    /// Transfer Y to Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TYA_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.registers.A = cpu.registers.Y

        cpu.flags.setZero(cpu.registers.A)
        cpu.flags.setNegative(cpu.registers.A)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
