extension Executor {
    /// Arithmetic Shift Left
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.ASL_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        let result = data << 1
        try cpu.write(
            byte: result,
            to: &memory,
            for: addressingMode)

        cpu.flags.C = (data & (1 << 7)) != 0
        cpu.flags.setZero(result)
        cpu.flags.setNegative(result)
        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
