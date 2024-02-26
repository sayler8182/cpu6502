extension CPU.Instruction {
    /// Load X register
    public enum LDX_OPCODE: Byte {
        /// 2B, 2C
        case IM = 0xA2

        /// 2B, 3C
        case ZP = 0xA6

        /// 2B, 4C
        case ZPY = 0xB6

        /// 3B, 4C
        case ABS = 0xAE

        /// 3B, 4C (+1 if page crossed)
        case ABSY = 0xBE

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IM: return .immediate
            case .ZP: return .zeroPage
            case .ZPY: return .zeroPageY
            case .ABS: return .absolute
            case .ABSY: return .absoluteY
            }
        }

        var size: Byte {
            switch self {
            case .IM: return 2
            case .ZP: return 2
            case .ZPY: return 2
            case .ABS: return 3
            case .ABSY: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .IM: return 2
            case .ZP: return 3
            case .ZPY: return 4
            case .ABS: return 4
            case .ABSY: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
