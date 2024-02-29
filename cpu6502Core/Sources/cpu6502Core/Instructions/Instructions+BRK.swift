extension CPU.Instruction {
    /// Force Interrupt / Force Break
    public enum BRK_OPCODE: Byte, OPCODE {
        /// 1B, 7C
        case IMPL = 0x00

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IMPL: return .implied
            }
        }

        var size: Byte {
            switch self {
            case .IMPL: return 1
            }
        }

        var cycles: Cycles {
            switch self {
            case .IMPL: return 7
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
