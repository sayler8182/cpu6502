extension CPU.Instruction {
    /// Jump to Subroutine
    public enum JSR_OPCODE: Byte, OPCODE {
        /// 3B, 6C
        case ABS = 0x20

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ABS: return .absolute
            }
        }

        var size: Byte {
            switch self {
            case .ABS: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ABS: return 6
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
