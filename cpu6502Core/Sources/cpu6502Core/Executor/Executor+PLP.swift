extension Executor {
    /// Pull Processor Status
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PLP_OPCODE
    ) throws -> ExecutorResult {
        let data: Byte = try cpu.pull(from: &memory)

        // bit always set to 1
        cpu.flags.value = data | CPU.StatusFlags.Flag.U.value

        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, 0)
    }
}
