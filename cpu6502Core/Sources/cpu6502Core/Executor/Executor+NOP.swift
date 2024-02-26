extension Executor {
    /// Do nothing
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.NOP_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let isCrossed = false
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}