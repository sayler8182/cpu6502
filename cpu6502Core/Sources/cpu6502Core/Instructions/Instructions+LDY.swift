extension CPU.Instruction {
    public enum LDY_OPCODE: Byte {
        /// Load value into the Y register
        /// 2B, 2C
        case IM = 0xA0

        /// Load Y register from address from ZeroPage
        /// 2B, 3C
        case ZP = 0xA4

        /// Load Y register from address from ZeroPage and adding the current value of the X register to it.
        /// 2B, 4C
        case ZPX = 0xB4

        /// Load Y register from address
        /// 2B, 4C
        case ABS = 0xAC

        /// Load Y register from address and adding the current value of the X register to it.
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
            case .ABS: return 2
            case .ABSX: return 3
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
