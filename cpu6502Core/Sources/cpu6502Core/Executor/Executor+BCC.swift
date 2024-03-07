extension Executor {
    /// Branch if Carry Clear
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        opcode: CPU.Instruction.BCC_OPCODE
    ) throws -> ExecutorResult {
        if !cpu.flags.C {
            let relativeByte = memory[cpu.PC + 1]
            let address = cpu.PC
            cpu.PC = relativeByte & (1 << 7) > 0
                ? address &- Word((~relativeByte & 0x7f) + 1 - opcode.size)
                : address &+ Word(relativeByte + opcode.size)

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
