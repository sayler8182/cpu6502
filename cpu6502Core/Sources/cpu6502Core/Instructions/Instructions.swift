extension CPU {
    public enum Instruction {
        public enum AddressingMode {
            case implicit
            case accumulator
            case immediate
            case zeroPage
            case zeroPageX
            case zeroPageY
            case relative
            case absolute
            case absoluteX
            case absoluteY
            case indirect
            case indirectX
            case indirectY
        }

        /// LDA - Load Accumulator
        /// A,Z,N = M
        /// Loads a byte of memory into the accumulator setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LDA(LDA_OPCODE)

        /// LDX - X Register
        /// X,Z,N = M
        /// Loads a byte of memory into the X register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LDX(LDX_OPCODE)

        /// LDY - Y Register
        /// X,Z,N = M
        /// Loads a byte of memory into the Y register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LDY(LDY_OPCODE)

        /// Indefined instruction
        case undefined(Byte)

        init(byte: Byte) {
            switch byte {
                /// any of LDA_OPCODE
            case 0xA9, 0xA5, 0xB5, 0xAD, 0xBD, 0xB9, 0xA1, 0xB1:
                self = .LDA(LDA_OPCODE(byte: byte))
                /// any of LDX_OPCODE
            case 0xA2, 0xA6, 0xB6, 0xAE, 0xBE:
                self = .LDX(LDX_OPCODE(byte: byte))
                /// any of LDY_OPCODE
            case 0xA0, 0xA4, 0xB4, 0xAC, 0xBC:
                self = .LDY(LDY_OPCODE(byte: byte))
            default:
                self = .undefined(byte)
            }
        }
    }
}
