internal enum ExecutorError: Error, CustomDebugStringConvertible {
    case undefinedInstruction(Byte)
    case unimplemented(Byte)

    var debugDescription: String {
        switch self {
        case .undefinedInstruction(let byte):
            return String(format: "ExecutorError - undefined instruction: '0x%@'", String(byte, radix: 16).uppercased())
        case .unimplemented(let byte):
            return String(format: "ExecutorError - unimplemented instruction: '0x%@'", String(byte, radix: 16).uppercased())
        }
    }
}

internal struct Executor {
    /// Executes program in memory
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(cpu: inout CPU,
                 memory: inout Memory,
                 instruction: CPU.Instruction) throws -> Cycles {
        switch instruction {
        case .LDA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .LDX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .LDY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .undefined(let byte):
            throw CPUError.undefinedInstruction(byte)
        }
    }
}
