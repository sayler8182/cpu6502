extension Executor {
    /// Transfer Stack Pointer to X
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.TSX_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.registers.X = cpu.SP

        cpu.flags.setZero(cpu.registers.X)
        cpu.flags.setNegative(cpu.registers.X)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
