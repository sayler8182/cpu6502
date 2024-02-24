extension CPU.Instruction {
    public enum LDX_OPCODE: Byte {
        /// Load value into the X register
        /// 2B, 2C
        case IM = 0xA2

        /// Load X register from address from ZeroPage
        /// 2B, 3C
        case ZP = 0xA6

        /// Load X register from address from ZeroPage and adding the current value of the Y register to it.
        /// 2B, 4C
        case ZPY = 0xB6

        /// Load X register from address
        /// 2B, 4C
        case ABS = 0xAE

        /// Load X register from address and adding the current value of the Y register to it.
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
            case .ABS: return 2
            case .ABSY: return 3
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
