extension CPU.Instruction {
    /// Store Accumulator
    public enum STA_OPCODE: Byte {
        /// 2B, 3C
        case ZP = 0x85
        /// 2B, 4C
        case ZPX = 0x95
        /// 3B, 4C
        case ABS = 0x8D
        /// 3B, 5C
        case ABSX = 0x9D
        /// 3B, 5C
        case ABSY = 0x99
        /// 2B, 6C
        case INDX = 0x81
        /// 2B, 6C
        case INDY = 0x91

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
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
            case .ZP: return 3
            case .ZPX: return 4
            case .ABS: return 4
            case .ABSX: return 5
            case .ABSY: return 5
            case .INDX: return 6
            case .INDY: return 6
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
