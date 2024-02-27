extension CPU.Instruction {
    /// Store X Register
    public enum STX_OPCODE: Byte {
        /// 2B, 3C
        case ZP = 0x86
        /// 2B, 4C
        case ZPY = 0x96
        /// 3B, 4C
        case ABS = 0x8E

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .ZP: return .zeroPage
            case .ZPY: return .zeroPageY
            case .ABS: return .absolute
            }
        }

        var size: Byte {
            switch self {
            case .ZP: return 2
            case .ZPY: return 2
            case .ABS: return 3
            }
        }

        var cycles: Cycles {
            switch self {
            case .ZP: return 3
            case .ZPY: return 4
            case .ABS: return 4
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
