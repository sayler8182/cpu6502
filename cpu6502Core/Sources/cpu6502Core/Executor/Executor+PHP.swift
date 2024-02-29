extension Executor {
    /// Push Processor Status
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PHP_OPCODE
    ) throws -> ExecutorResult {
        let data = cpu.flags.value | CPU.StatusFlags.Flag.B.value
        try cpu.push(
            byte: data,
            to: &memory)

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
