extension Executor {
    /// Rotate Right
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.ROR_OPCODE
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, isCrossed) = try cpu.read(
            from: memory,
            for: addressingMode)

        let c = cpu.flags.value & CPU.StatusFlags.Flag.C.value
        var result = data >> 1
        result = result | (c << 7)
        try cpu.write(
            byte: result,
            to: &memory,
            for: addressingMode)

        cpu.flags.C = (data & 0b00000001) != 0
        cpu.flags.setZero(result)
        cpu.flags.setNegative(result)

        cpu.moveProgramCounter(opcode.size)
        return (opcode.size, opcode.cycles, isCrossed)
    }
}
