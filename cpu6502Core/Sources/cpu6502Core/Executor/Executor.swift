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
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        instruction: CPU.Instruction
    ) throws -> (size: Byte, cycles: Cycles, isCrossed: Bool) {
        switch instruction {
        case .ADC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
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
        case .LSR(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .NOP(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .ORA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .PHA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .PHP(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .PLA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .PLP(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .ROL(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .ROR(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .RTI(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .RTS(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .SBC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .SEC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .SED(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .SEI(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .STA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .STX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .STY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .TAX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .undefined(let byte):
            throw CPUError.undefinedInstruction(byte)
        }
    }
}
