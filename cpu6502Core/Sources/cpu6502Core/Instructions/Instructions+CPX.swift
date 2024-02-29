extension CPU.Instruction {
    /// Compare X Register
    public enum CPX_OPCODE: Byte, OPCODE {
        /// 2B, 2C
        case IM = 0xE0
        /// 2B, 3C
        case ZP = 0xE4
        /// 3B, 4C
        case ABS = 0xEC

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
