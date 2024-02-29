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

internal typealias ExecutorResult = (size: Byte, cycles: Cycles, additionalCycles: Cycles)

internal struct Executor {
    /// Executes program in memory
    /// - Throws: ExecutorError
    /// - Returns: Spend cycles
    func execute(
        cpu: inout CPU,
        memory: inout Memory,
        instruction: CPU.Instruction
    ) throws -> ExecutorResult {
        switch instruction {
        case .ADC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .AND(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .ASL(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BCC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BCS(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BEQ(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BIT(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BMI(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BNE(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BPL(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BRK(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BVC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .BVS(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CLC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CLD(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CLI(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CLV(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CMP(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CPX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .CPY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .DEC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .DEX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .DEY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .EOR(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .INC(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .INX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .INY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .JMP(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .JSR(let opcode):
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
        case .TAY(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .TSX(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .TXA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .TXS(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .TYA(let opcode):
            try execute(
                cpu: &cpu,
                memory: &memory,
                opcode: opcode)
        case .undefined(let byte):
            throw CPUError.undefinedInstruction(byte)
        }
    }
}
