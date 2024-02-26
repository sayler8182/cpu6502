extension Executor {
    /// Push Processor Status
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.PHP_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let data = cpu.flags.value | CPU.StatusFlags.Flag.B.value | CPU.StatusFlags.Flag.U.value
        try cpu.push(
            byte: data,
            to: &memory)

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
