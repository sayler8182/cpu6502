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

        /// LDX - Load X Register
        /// X,Z,N = M
        /// Loads a byte of memory into the X register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LDX(LDX_OPCODE)

        /// LDY - Load Y Register
        /// X,Z,N = M
        /// Loads a byte of memory into the Y register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LDY(LDY_OPCODE)

        /// LSR - Logical Shift Right
        /// A,C,Z,N = A/2 or M,C,Z,N = M/2
        /// Each of the bits in A or M is shift one place to the right. The bit that was in bit 0 is shifted into the carry flag. Bit 7 is set to zero.
        ///  - C - Cerry Flag - Set if last bit was set to 1
        ///  - Z - Zero Flag - Set if A = 0
        ///  - N - Negative Flag - Set if bit 7 of A is set
        case LSR(LSR_OPCODE)

        /// NOP - No Operation
        /// The NOP instruction causes no changes to the processor other than the normal incrementing of the program counter to the next instruction.
        case NOP(NOP_OPCODE)

        /// ORA - Logical Inclusive OR
        /// A,Z,N = A|M
        /// An inclusive OR is performed, bit by bit, on the accumulator contents using the contents of a byte of memory.
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case ORA(ORA_OPCODE)

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
            case 0x4A, 0x46, 0x56, 0x4E, 0x5E:
                self = .LSR(LSR_OPCODE(byte: byte))
            case 0xEA:
                self = .NOP(NOP_OPCODE(byte: byte))
            case 0x09, 0x05, 0x15, 0x0D, 0x1D, 0x19, 0x01, 0x11:
                self = .ORA(ORA_OPCODE(byte: byte))
            default:
                self = .undefined(byte)
            }
        }
    }
}
