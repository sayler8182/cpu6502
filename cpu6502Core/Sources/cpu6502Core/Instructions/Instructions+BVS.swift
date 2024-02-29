extension CPU.Instruction {
    /// Branch if Overflow Set
    public enum BVS_OPCODE: Byte, OPCODE {
        /// 1B, 2C  (+1 if branch succeeds, +2 if to a new page)
        case REL = 0x70

        var byte: Byte {
            rawValue
        }

        var addressingMode: AddressingMode {
            switch self {
            case .REL: return .relative
            }
        }

        var size: Byte {
            switch self {
            case .REL: return 2
            }
        }

        var cycles: Cycles {
            switch self {
            case .REL: return 2
            }
        }

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
