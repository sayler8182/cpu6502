extension CPU.Instruction {
    /// Decrement Memory
    public enum DEC_OPCODE: Byte, OPCODE {
        /// 2B, 5C
        case ZP = 0xC6
        /// 2B, 6C
        case ZPX = 0xD6
        /// 3B, 6C
        case ABS = 0xCE
        /// 3B, 7C
        case ABSX = 0xDE

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ZP: return .zeroPage
            case .ZPX: return .zeroPageX
            case .ABS: return .absolute
            case .ABSX: return .absoluteX
            }
        }

        var size: Byte {
            switch self {
            case .ZP: return 2
            case .ZPX: return 2
            case .ABS: return 3
            case .ABSX: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ZP: return 5
            case .ZPX: return 6
            case .ABS: return 6
            case .ABSX: return 7
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
