extension CPU.Instruction {
    /// Arithmetic Shift Left
    public enum ASL_OPCODE: Byte, OPCODE {
        /// 1B, 2C
        case ACC = 0x0A
        /// 2B, 5C
        case ZP = 0x06
        /// 2B, 6C
        case ZPX = 0x16
        /// 3B, 6C
        case ABS = 0x0E
        /// 3B, 7C
        case ABSX = 0x1E

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
