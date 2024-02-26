extension CPU.Instruction {
    /// Do nothing
    public enum NOP_OPCODE: Byte {
        /// 1B, 2C
        case IMPL = 0xEA

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
            case .IMPL: return 2
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
