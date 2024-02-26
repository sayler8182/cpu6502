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

        /// PHA - Push Accumulator
        /// Pushes a copy of the accumulator on to the stack.
        case PHA(PHA_OPCODE)

        /// PHA - Push Processor Status
        /// Pushes a copy of the status flags on to the stack.
        /// - U - Unused - is always set to 1
        /// - B - Break - is always set to 1
        case PHP(PHP_OPCODE)

        /// PLA - Pull Accumulator
        /// Pulls an 8 bit value from the stack and into the accumulator. The zero and negative flags are set as appropriate.
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case PLA(PLA_OPCODE)

        /// PLP - Processor Status
        /// Pulls an 8 bit value from the stack and into the processor flags. The flags will take on new states as determined by the value pulled.
        /// The status register will be pulled with the break flag and bit 5 ignored.
        case PLP(PLP_OPCODE)

        /// ROL - Rotate Left
        /// Move each of the bits in either A or M one place to the left. Bit 0 is filled with the current value of the carry flag whilst the old bit 7 becomes the new carry flag value.
        /// - C - Carry Flag - Set if old bit 7 is set
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case ROL(ROL_OPCODE)

        /// ROL - Rotate Right
        /// Move each of the bits in either A or M one place to the right. Bit 7 is filled with the current value of the carry flag whilst the old bit 0 becomes the new carry flag value.
        /// - C - Carry Flag - Set if old bit 7 is set
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case ROR(ROR_OPCODE)

        /// RTI - Return from Interrupt
        /// The RTI instruction is used at the end of an interrupt processing routine. It pulls the processor flags from the stack followed by the program counter.
        /// The status register is pulled with the break flag and bit 5 ignored. Then PC is pulled from the stack.
        case RTI(RTI_OPCODE)

        /// RTS - Return from Interrupt
        /// The RTS instruction is used at the end of a subroutine to return to the calling routine. It pulls the program counter (minus one) from the stack.
        case RTS(RTS_OPCODE)

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
            case 0x48:
                self = .PHA(PHA_OPCODE(byte: byte))
            case 0x08:
                self = .PHP(PHP_OPCODE(byte: byte))
            case 0x68:
                self = .PLA(PLA_OPCODE(byte: byte))
            case 0x28:
                self = .PLP(PLP_OPCODE(byte: byte))
            case 0x2A, 0x26, 0x36, 0x2E, 0x3E:
                self = .ROL(ROL_OPCODE(byte: byte))
            case 0x6A, 0x66, 0x76, 0x6E, 0x7E:
                self = .ROR(ROR_OPCODE(byte: byte))
            case 0x40:
                self = .RTI(RTI_OPCODE(byte: byte))
            case 0x60:
                self = .RTS(RTS_OPCODE(byte: byte))
            default:
                self = .undefined(byte)
            }
        }
    }
}
