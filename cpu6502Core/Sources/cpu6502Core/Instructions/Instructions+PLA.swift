extension CPU.Instruction {
    /// Pull Accumulator
    public enum PLA_OPCODE: Byte {
        /// 1B, 4C
        case IMPL = 0x68

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IMPL: return .implied
            }
        }

        var size: Byte {
            switch self {
            case .IMPL: return 1
            }
        }

        var cycles: Cycles {
            switch self {
            case .IMPL: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
