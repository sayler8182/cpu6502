extension CPU.Instruction {
    /// Push Processor Status
    public enum PHP_OPCODE: Byte {
        /// 1B, 3C
        case IMPL = 0x08

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
            case .IMPL: return 3
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
