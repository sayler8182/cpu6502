extension CPU.Instruction {
    /// Return from Subroutine
    public enum RTS_OPCODE: Byte {
        /// 1B, 6C
        case IMPL = 0x60

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .IMPL: return .implicit
            }
        }

        var size: Byte {
            switch self {
            case .IMPL: return 1
            }
        }

        var cycles: Cycles {
            switch self {
            case .IMPL: return 6
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
