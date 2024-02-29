extension Executor {
    /// Compare
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.CMP_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, additionalCycles) = try cpu.read(
            from: memory,
            for: addressingMode)

        let base = cpu.registers.A
        let result = base
            .subtractingWithOverflow(data)

        cpu.flags.C = base >= data
        cpu.flags.Z = result == 0
        cpu.flags.N = (result & CPU.StatusFlags.Flag.N.value) != 0
        cpu.PC += Word(opcode.size)
        return (opcode.size, opcode.cycles, additionalCycles)
    }
}
