extension Executor {
    /// Set Decimal Flag
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SED_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.flags.D = true

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
