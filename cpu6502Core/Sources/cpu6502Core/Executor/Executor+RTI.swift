extension Executor {
    /// Return from Interrupt
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.RTI_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        var byte: Byte = try cpu.pull(from: &memory)

        // break flag and bit 5 ignored
        byte = byte & ~(CPU.StatusFlags.Flag.U.value | CPU.StatusFlags.Flag.B.value)
        let u = cpu.flags.value & CPU.StatusFlags.Flag.U.value
        let b = cpu.flags.value & CPU.StatusFlags.Flag.B.value
        cpu.flags.value = byte | u | b

        let word: Word = try cpu.pull(from: &memory)
        cpu.PC = word

        return (opcode.size, opcode.cycles, false)
    }
}
