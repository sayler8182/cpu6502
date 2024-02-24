extension CPU.Instruction {
    public enum LSR_OPCODE: Byte {
        /// Shift right value in acumulator
        /// 1B, 2C
        case ACC = 0x4A

        /// Shift right value in address from ZeroPage
        /// 2B, 5C
        case ZP = 0x46

        /// Shift right value in address from ZeroPage and adding the current value of the X register to it.
        /// 2B, 6C
        case ZPX = 0x56

        /// Shift right value in address
        /// 3B, 6C
        case ABS = 0x4E

        /// Shift right value in address and adding the current value of the X register to it.
        /// 3B, 7C
        case ABSX = 0x5E

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

        init(byte: Byte) {
            self.init(rawValue: byte)!
        }
    }
}
