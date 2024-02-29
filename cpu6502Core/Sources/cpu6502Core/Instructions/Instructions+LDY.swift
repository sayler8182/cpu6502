extension CPU.Instruction {
    /// Load Y register
    public enum LDY_OPCODE: Byte, OPCODE {
        /// 2B, 2C
        case IM = 0xA0
        /// 2B, 3C
        case ZP = 0xA4
        /// 2B, 4C
        case ZPX = 0xB4
        /// 3B, 4C
        case ABS = 0xAC
        /// 3B, 4C (+1 if page crossed)
        case ABSX = 0xBC

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IM: return .immediate
            case .ZP: return .zeroPage
            case .ZPX: return .zeroPageX
            case .ABS: return .absolute
            case .ABSX: return .absoluteX
            }
        }

        var size: Byte {
            switch self {
            case .IM: return 2
            case .ZP: return 2
            case .ZPX: return 2
            case .ABS: return 3
            case .ABSX: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .IM: return 2
            case .ZP: return 3
            case .ZPX: return 4
            case .ABS: return 4
            case .ABSX: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
