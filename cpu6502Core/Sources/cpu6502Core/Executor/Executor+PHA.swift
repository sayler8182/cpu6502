extension Executor {
    /// Push Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PHA_OPCODE
    ) throws -> ExecutorResult {
        let data = cpu.registers.A
        try cpu.push(
            byte: data,
            to: &memory)

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
