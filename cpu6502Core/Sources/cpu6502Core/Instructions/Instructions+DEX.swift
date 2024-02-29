extension CPU.Instruction {
    /// Decrement X Register
    public enum DEX_OPCODE: Byte, OPCODE {
        /// 1B, 2C
        case IMPL = 0xCA

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
            case .IMPL: return 2
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
