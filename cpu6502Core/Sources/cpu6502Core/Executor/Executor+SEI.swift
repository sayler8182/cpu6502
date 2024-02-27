extension Executor {
    /// Set Interrupt Disable
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SEI_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.flags.I = true

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
