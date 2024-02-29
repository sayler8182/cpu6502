extension Executor {
    /// Return from Interrupt
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.RTI_OPCODE
    ) throws -> ExecutorResult {
        let byte: Byte = try cpu.pull(from: &memory)

        // bit always set to 1
        cpu.flags.value = byte | CPU.StatusFlags.Flag.U.value

        let word: Word = try cpu.pull(from: &memory)
        cpu.PC = word

        return (opcode.size, opcode.cycles, 0)
    }
}
