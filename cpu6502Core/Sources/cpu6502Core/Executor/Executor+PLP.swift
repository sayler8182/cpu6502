extension Executor {
    /// Pull Processor Status
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PLP_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        var data: Byte = try cpu.pull(from: &memory)

        // break flag and bit 5 ignored
        data = data & ~(CPU.StatusFlags.Flag.U.value | CPU.StatusFlags.Flag.B.value)
        let u = cpu.flags.value & CPU.StatusFlags.Flag.U.value
        let b = cpu.flags.value & CPU.StatusFlags.Flag.B.value
        cpu.flags.value = data | u | b

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
