extension CPU.Instruction {
    /// Load value into the accumulator
    public enum LDA_OPCODE: Byte {
        /// 2B, 2C
        case IM = 0xA9
        /// 2B, 3C
        case ZP = 0xA5
        /// 2B, 4C
        case ZPX = 0xB5
        /// 2B, 4C
        case ABS = 0xAD
        /// 3B, 4C (+1 if page crossed)
        case ABSX = 0xBD
        /// 3B, 4C (+1 if page crossed)
        case ABSY = 0xB9
        /// 2B, 6C
        case INDX = 0xA1
        /// 2B, 5C (+1 if page crossed)
        case INDY = 0xB1

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
            case .ABSY: return .absoluteY
            case .INDX: return .indirectX
            case .INDY: return .indirectY
            }
        }

        var size: Byte {
            switch self {
            case .IM: return 2
            case .ZP: return 2
            case .ZPX: return 2
            case .ABS: return 2
            case .ABSX: return 3
            case .ABSY: return 3
            case .INDX: return 2
            case .INDY: return 2
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
