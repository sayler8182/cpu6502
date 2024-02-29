extension CPU.Instruction {
    /// Add with Carry
    public enum ADC_OPCODE: Byte, OPCODE {
        /// 2B, 2C
        case IM = 0x69
        /// 2B, 3C
        case ZP = 0x65
        /// 2B, 4C
        case ZPX = 0x75
        /// 3B, 4C
        case ABS = 0x6D
        /// 3B, 4C (+1 if page crossed)
        case ABSX = 0x7D
        /// 3B, 4C (+1 if page crossed)
        case ABSY = 0x79
        /// 2B, 6C
        case INDX = 0x61
        /// 2B, 5C (+1 if page crossed)
        case INDY = 0x71

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
            case .ABS: return 3
            case .ABSX: return 3
            case .ABSY: return 3
            case .INDX: return 2
            case .INDY: return 2
            }
        }

        var cycles: Cycles {
            switch self {
            case .IM: return 2
            case .ZP: return 3
            case .ZPX: return 4
            case .ABS: return 4
            case .ABSX: return 4
            case .ABSY: return 4
            case .INDX: return 6
            case .INDY: return 5
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
