extension CPU.Instruction {
    /// Store Y Register
    public enum STY_OPCODE: Byte, OPCODE {
        /// 2B, 3C
        case ZP = 0x84
        /// 2B, 4C
        case ZPX = 0x94
        /// 3B, 4C
        case ABS = 0x8C

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ZP: return .zeroPage
            case .ZPX: return .zeroPageX
            case .ABS: return .absolute
            }
        }

        var size: Byte {
            switch self {
            case .ZP: return 2
            case .ZPX: return 2
            case .ABS: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ZP: return 3
            case .ZPX: return 4
            case .ABS: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
