extension Executor {
    /// Set Carry Flag
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SEC_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        cpu.flags.C = true

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
