extension CPU.Instruction {
    /// Rotate right
    public enum ROR_OPCODE: Byte {
        /// 1B, 2C
        case ACC = 0x6A
        /// 2B, 5C
        case ZP = 0x66
        /// 2B, 6C
        case ZPX = 0x76
        /// 3B, 6C
        case ABS = 0x6E
        /// 3B, 7C
        case ABSX = 0x7E

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ACC: return .accumulator
            case .ZP: return .zeroPage
            case .ZPX: return .zeroPageX
            case .ABS: return .absolute
            case .ABSX: return .absoluteX
            }
        }

        var size: Byte {
            switch self {
            case .ACC: return 1
            case .ZP: return 2
            case .ZPX: return 2
            case .ABS: return 3
            case .ABSX: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ACC: return 2
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
