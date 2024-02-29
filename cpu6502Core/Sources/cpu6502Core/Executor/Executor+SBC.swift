extension Executor {
    /// Subtract with Carry
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.SBC_OPCODE
    ) throws -> ExecutorResult {
        let addressingMode = cpu.addressingMode(
            from: opcode.addressingMode,
            memory: memory,
            size: opcode.size)
        let (data, additionalCycles) = try cpu.read(
            from: memory,
            for: addressingMode)

        if !cpu.flags.D {
            let cBit: Byte = cpu.flags.C ? 0b0 : 0b1
            let base = cpu.registers.A
            let resultWord = Word(base)
                .subtractingWithOverflow(Word(data))
                .subtractingWithOverflow(Word(cBit))
            let resultByte = Byte(resultWord & 0xFF)

            cpu.flags.C = (resultWord >> 8) == 0
            cpu.flags.V = ((base ^ data) & (base ^ resultByte) & 0x80) > 0

            cpu.registers.A = resultByte

            cpu.flags.Z = resultByte == 0
            cpu.flags.N = (resultByte & CPU.StatusFlags.Flag.N.value) != 0
            cpu.PC += Word(opcode.size)
        } else {
            let cBit: Byte = cpu.flags.C ? 0b0 : 0b1
            let lowDigit = Word(cpu.registers.A & 0x0F)
                .subtractingWithOverflow(Word(data & 0x0F))
                .subtractingWithOverflow(Word(cBit))
            let lowDigitNew = lowDigit > 0xFF ? (lowDigit.subtractingWithOverflow(Byte(0x06)) & 0x0F) : lowDigit
            let highDigitCarry = (lowDigit > 0xFF ? lowDigitNew.subtractingWithOverflow(Byte(0x10)) : lowDigitNew)

            var result = Word(cpu.registers.A & 0xF0)
                .subtractingWithOverflow(Word(data & 0xF0))
                .addingWithOverflow(highDigitCarry)

            cpu.flags.N = (Byte(result & 0xFF) & CPU.StatusFlags.Flag.N.value) != 0

            result = result >= 0xFF ? result.subtractingWithOverflow(Byte(0x60)) : result
            cpu.registers.A = Byte((result & 0xFF))

            let resultV = (Byte(result & 0xFF) ^ cpu.registers.A) & (Byte(result & 0xFF) ^ data)
            cpu.flags.V = (resultV & 0x0080) != 0

            cpu.flags.Z = (result & 0xFF) == 0
            cpu.flags.C = result < 0xFF
            cpu.PC += Word(opcode.size)
        }

        return (opcode.size, opcode.cycles, additionalCycles)
    }
}
