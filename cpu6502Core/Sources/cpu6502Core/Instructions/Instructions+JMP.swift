extension CPU.Instruction {
    /// Jump
    public enum JMP_OPCODE: Byte, OPCODE {
        /// 3B, 3C
        case ABS = 0x4C
        /// 3B, 5C
        case IND = 0x6C

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ABS: return .absolute
            case .IND: return .indirect
            }
        }

        var size: Byte {
            switch self {
            case .ABS: return 3
            case .IND: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ABS: return 3
            case .IND: return 5
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
