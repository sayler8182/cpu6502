extension Executor {
    /// Store Y Register
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.STY_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)

        try cpu.write(
            byte: cpu.registers.Y,
            to: &memory,
            for: addressingMode)

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, false)
    }
}
