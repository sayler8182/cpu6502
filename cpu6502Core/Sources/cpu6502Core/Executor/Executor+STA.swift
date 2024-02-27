extension Executor {
    /// Store Accumulator
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.STA_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)

        try cpu.write(
            byte: cpu.registers.A,
            to: &memory,
            for: addressingMode)

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
