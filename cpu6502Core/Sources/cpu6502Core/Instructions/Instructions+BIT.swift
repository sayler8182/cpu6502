extension CPU.Instruction {
    /// Branch if Equal
    public enum BIT_OPCODE: Byte, OPCODE {
        /// 2B, 3C
        case ZP = 0x24
        /// 3B, 4C
        case ABS = 0x2C

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ZP: return .zeroPage
            case .ABS: return .absolute
            }
        }

        var size: Byte {
            switch self {
            case .ZP: return 2
            case .ABS: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ZP: return 3
            case .ABS: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
