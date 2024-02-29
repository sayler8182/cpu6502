extension CPU.Instruction {
    /// Compare Y Register
    public enum CPY_OPCODE: Byte, OPCODE {
        /// 2B, 2C
        case IM = 0xC0
        /// 2B, 3C
        case ZP = 0xC4
        /// 3B, 4C
        case ABS = 0xCC

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IM: return .immediate
            case .ZP: return .zeroPage
            case .ABS: return .absolute
            }
        }

        var size: Byte {
            switch self {
            case .IM: return 2
            case .ZP: return 2
            case .ABS: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .IM: return 2
            case .ZP: return 3
            case .ABS: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
