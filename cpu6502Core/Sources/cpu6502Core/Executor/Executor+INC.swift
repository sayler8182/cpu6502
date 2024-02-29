extension Executor {
    /// Increment Memory
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.INC_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, additionalCycles) = try cpu.read(
            from: memory,
            for: addressingMode)

        let result = data
            .addingWithOverflow(1)

        try cpu.write(
            byte: result,
            to: &memory,
            for: addressingMode)

        cpu.flags.Z = result == 0
        cpu.flags.N = (result & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, additionalCycles)
    }
}
