extension Executor {
    /// Branch if Positive
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.BPL_OPCODE
    ) throws -> ExecutorResult {
        if !cpu.flags.N {
            let relativeByte = memory[cpu.PC + 1]
            let address = cpu.PC
            cpu.PC = relativeByte & (1 << 7) > 0
                ? address.subtractingWithOverflow((~relativeByte & 0x7f) + 1 - opcode.size)
                : address.addingWithOverflow(relativeByte + opcode.size)

            // crossing page
            if (address ^ cpu.PC) >> 8 != 0 {
                return (opcode.size, opcode.cycles, 2)
            } else {
                return (opcode.size, opcode.cycles, 1)
            }
        } else {
            cpu.PC += Word(opcode.size)
            return (opcode.size, opcode.cycles, 0)
        }
    }
}
