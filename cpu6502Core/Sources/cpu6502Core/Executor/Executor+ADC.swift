extension Executor {
    /// Add with Carry
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.ADC_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, additionalCycles) = try cpu.read(
            from: memory,
            for: addressingMode)

        if !cpu.flags.D {
            let cBit: Byte = cpu.flags.C ? 0b1 : 0b0
            let base = cpu.registers.A
            let resultWord = Word(base) + Word(data) + Word(cBit)
            let resultByte = Byte(resultWord & 0xFF)

            cpu.flags.C = resultWord > 0xFF
            cpu.flags.Z = resultByte == 0
            cpu.flags.V = ((resultByte ^ base) & (resultByte ^ data) & 0x0080) > 0
            cpu.flags.N = (resultByte & CPU.StatusFlags.Flag.N.value) != 0

            cpu.registers.A = resultByte

            cpu.PC += Word(opcode.size)
        } else {
            let cBit: Byte = cpu.flags.C ? 0b1 : 0b0
            let realResult = Word(cpu.registers.A) + Word(data) + Word(cBit)
            var lowDigit = Word(cpu.registers.A & 0x0F) + Word(data & 0x0F) + Word(cBit)
            lowDigit = lowDigit > 0x09 ? lowDigit + 0x06 : lowDigit
            let highDigitCarry = (lowDigit > 0x0F ? 0x10 : 0x00) + (lowDigit & 0x0F)

            var result: Word = (Word(cpu.registers.A) & 0xF0) + (Word(data) & 0xF0) + highDigitCarry
            let resultV = (Word(result) ^ Word(cpu.registers.A)) & (Word(result) ^ Word(data))
            cpu.flags.V = (resultV & 0x0080) != 0
            cpu.flags.N = (Byte(result & 0xFF) & CPU.StatusFlags.Flag.N.value) != 0

            result = result > 0x9F ? result + 0x60 : result
            cpu.registers.A = Byte((result & 0xFF))

            cpu.flags.Z = (realResult & 0xFF) == 0
            cpu.flags.C = result > 0xFF
            cpu.PC += Word(opcode.size)
        }

        return (opcode.size, opcode.cycles, additionalCycles)
    }
}
