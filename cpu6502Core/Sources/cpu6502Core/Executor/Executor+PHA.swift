extension Executor {
    /// Push Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PHA_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let data = cpu.registers.A
        try cpu.push(
            byte: data,
            to: &memory)

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
