extension CPU.Instruction {
    /// Push Accumulator
    public enum PHA_OPCODE: Byte, OPCODE {
        /// 1B, 3C
        case IMPL = 0x48

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
            case .IMPL: return 3
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
