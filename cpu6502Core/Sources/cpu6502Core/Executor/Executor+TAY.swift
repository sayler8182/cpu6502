extension Executor {
    /// Transfer Accumulator to Y
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TAY_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.registers.Y = cpu.registers.A

        cpu.flags.setZero(cpu.registers.Y)
        cpu.flags.setNegative(cpu.registers.Y)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
