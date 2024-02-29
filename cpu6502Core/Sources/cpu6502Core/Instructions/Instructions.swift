protocol OPCODE: CaseIterable {
    static var info: String { get }

    var byte: Byte { get }
    var addressingMode: CPU.Instruction.AddressingMode { get }
    var size: Byte { get }
    var cycles: Cycles { get }
}

extension OPCODE {
    static var info: String {
        var result: String = ""
        result += "\(String("\(self)".prefix(3)))"
        for element in allCases {
            result += "\n- "
            result += "0x" + String(element.byte, radix: 16)
            result += " (" + element.addressingMode.rawValue
            result += ", " + String(element.size) + "B"
            result += ", " + String(element.cycles) + "C"
            result += ")"
        }
        return result
    }
}

extension CPU {
    public enum Instruction {
        public enum AddressingMode: String {
            case implied = "IMPL"
            case accumulator = "ACC"
            case immediate = "IM"
            case zeroPage = "ZP"
            case zeroPageX = "ZPX"
            case zeroPageY = "ZPY"
            case relative = "REL"
            case absolute = "ABS"
            case absoluteX = "ABSX"
            case absoluteY = "ABSY"
            case indirect = "IND"
            case indirectX = "INDX"
            case indirectY = "INDY"
        }

        /// ADC - Add with Carry
        /// A,Z,C,N = A+M+C
        /// This instruction adds the contents of a memory location to the accumulator together with the carry bit. If overflow occurs the carry bit is set, this enables multiple byte addition to be performed.
        /// - C - Carry Flag - Set if overflow in bit 7
        /// - Z - Zero Flag - Set if A = 0
        /// - V - Overflow - Set if sign bit is incorrect
        /// - N - Negative Flag - Set if bit 7 of A is set
        case ADC(ADC_OPCODE)

        /// AND - Logical AND
        /// A,Z,N = A&M
        /// A logical AND is performed, bit by bit, on the accumulator contents using the contents of a byte of memory.
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case AND(AND_OPCODE)

        /// ASL - Arithmetic Shift Left
        /// A,Z,C,N = M*2 or M,Z,C,N = M*2
        /// This operation shifts all the bits of the accumulator or memory contents one bit left. Bit 0 is set to 0 and bit 7 is placed in the carry flag. The effect of this operation is to multiply the memory contents by 2 (ignoring 2's complement considerations), setting the carry if the result will not fit in 8 bits.
        /// - C - Carry Flag - Set to contents of old bit 7
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case ASL(ASL_OPCODE)

        /// BCC - Branch if Carry Clear
        /// If the carry flag is clear then add the relative displacement to the program counter to cause a branch to a new location.
        case BCC(BCC_OPCODE)

        /// BCS - Branch if Carry Set
        /// If the carry flag is set then add the relative displacement to the program counter to cause a branch to a new location.
        case BCS(BCS_OPCODE)

        /// BEQ - Branch if Equal
        /// If the zero flag is set then add the relative displacement to the program counter to cause a branch to a new location.
        case BEQ(BEQ_OPCODE)

        /// BIT - Bit Test
        /// A & M, N = M7, V = M6
        /// This instructions is used to test if one or more bits are set in a target memory location. The mask pattern in A is ANDed with the value in memory to set or clear the zero flag, but the result is not kept. Bits 7 and 6 of the value from memory are copied into the N and V flags.
        /// - Z - Zero Flag - Set if result = 0
        /// - N - Negative Flag - Set if bit 7 of result is set
        /// - V - Overflow - Set if bit 6 of result is set
        case BIT(BIT_OPCODE)

        /// BMI - Branch if Minus
        /// If the negative flag is set then add the relative displacement to the program counter to cause a branch to a new location.
        case BMI(BMI_OPCODE)

        /// BNE - Branch if Not Equal
        /// If the zero flag is clear then add the relative displacement to the program counter to cause a branch to a new location.
        case BNE(BNE_OPCODE)

        /// BPL - Branch if Positive
        /// If the negative flag is clear then add the relative displacement to the program counter to cause a branch to a new location.
        case BPL(BPL_OPCODE)

        /// BRK - Force Interrupt
        /// The BRK instruction forces the generation of an interrupt request. The program counter and processor status are pushed on the stack then the IRQ interrupt vector at $FFFE/F is loaded into the PC and the break flag in the status set to one.
        /// The interpretation of a BRK depends on the operating system. On the BBC Microcomputer it is used by language ROMs to signal run time errors but it could be used for other purposes (e.g. calling operating system functions, etc.).
        ///  - B - Break Command - Set to 1
        case BRK(BRK_OPCODE)

        /// BVC - Branch if Overflow Clear
        /// If the overflow flag is clear then add the relative displacement to the program counter to cause a branch to a new location.
        case BVC(BVC_OPCODE)

        /// BVS - If the overflow flag is set then add the relative displacement to the program counter to cause a branch to a new location.
        /// If the overflow flag is clear then add the relative displacement to the program counter to cause a branch to a new location.
        case BVS(BVS_OPCODE)

        /// CLC - Clear Carry Flag
        /// C = 0
        /// - C - Carry Flag - Set to 0
        case CLC(CLC_OPCODE)

        /// CLD - Clear Decimal Mode
        /// The state of the decimal flag is uncertain when the CPU is powered up and it is not reset when an interrupt is generated. In both cases you should include an explicit CLD to ensure that the flag is cleared before performing addition or subtraction.
        /// D = 0
        /// - D - Decimal Mode - Set to 0
        case CLD(CLD_OPCODE)

        /// CLI - Clear Interrupt Disable
        /// Clears the interrupt disable flag allowing normal interrupt requests to be serviced.
        /// I = 0
        /// - I - Interrupt Disable - Set to 0
        case CLI(CLI_OPCODE)

        /// CLV - Clear Interrupt Disable
        /// V = 0
        /// - V - Overflow Flag - Set to 0
        case CLV(CLV_OPCODE)

        /// CMP - Compare
        /// Z,C,N = A-M
        /// This instruction compares the contents of the accumulator with another memory held value and sets the zero and carry flags as appropriate.
        ///  - C - Carry Flag - Set if A >= M
        ///  - Z - Zero Flag - Set if A = M
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case CMP(CMP_OPCODE)

        /// CPX - Compare X Registe
        /// Z,C,N = X-M
        /// This instruction compares the contents of the X register with another memory held value and sets the zero and carry flags as appropriate.
        ///  - C - Carry Flag - Set if X >= M
        ///  - Z - Zero Flag - Set if X = M
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case CPX(CPX_OPCODE)

        /// CPX - Compare Y Registe
        /// Z,C,N = Y-M
        /// This instruction compares the contents of the Y register with another memory held value and sets the zero and carry flags as appropriate.
        ///  - C - Carry Flag - Set if Y >= M
        ///  - Z - Zero Flag - Set if Y = M
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case CPY(CPY_OPCODE)

        /// DEC - Decrement Memory
        /// M,Z,N = M-1
        /// Subtracts one from the value held at a specified memory location setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case DEC(DEC_OPCODE)

        /// DEX - Decrement X Register
        /// X,Z,N = X-1
        /// Subtracts one from the X register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case DEX(DEX_OPCODE)

        /// DEY - Decrement Y Register
        /// Y,Z,N = Y-1
        /// Subtracts one from the Y register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case DEY(DEY_OPCODE)

        /// EOR - Exclusive OR
        /// A,Z,N = A^M
        /// An exclusive OR is performed, bit by bit, on the accumulator contents using the contents of a byte of memory.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case EOR(EOR_OPCODE)

        /// INC - Increment Memory
        /// M,Z,N = M + 1
        /// Adds one to the value held at a specified memory location setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case INC(INC_OPCODE)

        /// INX - Increment X Register
        /// X,Z,N = X+1
        /// Adds one to the X register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case INX(INX_OPCODE)

        /// INY - Increment X Register
        /// Y,Z,N = Y+1
        /// Adds one to the Y register setting the zero and negative flags as appropriate.
        ///  - Z - Zero Flag - Set if result = 0
        ///  - N - Negative Flag - Set if bit 7 of result is set
        case INY(INY_OPCODE)

        /// JMP - Jump
        /// Sets the program counter to the address specified by the operand.
        /// An original 6502 has does not correctly fetch the target address if the indirect vector falls on a page boundary (e.g. $xxFF where xx is any value from $00 to $FF). In this case fetches the LSB from $xxFF as expected but takes the MSB from $xx00. This is fixed in some later chips like the 65SC02 so for compatibility always ensure the indirect vector is not at the end of the page.
        case JMP(JMP_OPCODE)

        /// JSR - Jump to Subroutine
        /// The JSR instruction pushes the address (minus one) of the return point on to the stack and then sets the program counter to the target memory address.
        case JSR(JSR_OPCODE)

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
        ///  - C - Carry Flag - Set to contents of old bit 0
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

        /// SBC - Subtract with Carry
        /// A,Z,C,N = A-M-(1-C)
        /// This instruction subtracts the contents of a memory location to the accumulator together with the not of the carry bit. If overflow occurs the carry bit is clear, this enables multiple byte subtraction to be performed.
        /// - C - Carry Flag - Clear if overflow in bit 7
        /// - Z - Zero Flag - Set if A = 0
        /// - V - Overflow - Set if sign bit is incorrect
        /// - N - Negative Flag - Set if bit 7 of A is set
        case SBC(SBC_OPCODE)

        /// SEC - Set Carry Flag
        /// C = 1
        /// - C - Carry Flag - Set to 1
        case SEC(SEC_OPCODE)

        /// SEC - Set Decimal Flag
        /// D = 1
        /// - D - Decimal Flag - Set to 1
        case SED(SED_OPCODE)

        /// SEI - Set Interrupt Disable
        /// I = 1
        /// - I - Interrupt disable - Set to 1
        case SEI(SEI_OPCODE)

        /// STA - Store Accumulator
        /// M = A
        /// Stores the contents of the accumulator into memory.
        case STA(STA_OPCODE)

        /// STX - Store X Register
        /// M = X
        /// Stores the contents of the X register into memory.
        case STX(STX_OPCODE)

        /// STY - Store Y Register
        /// M = Y
        /// Stores the contents of the Y register into memory.
        case STY(STY_OPCODE)

        /// TAX - Store X Register
        /// X = A
        /// Copies the current contents of the accumulator into the X register and sets the zero and negative flags as appropriate.
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case TAX(TAX_OPCODE)

        /// TAY - Store Y Register
        /// Y = A
        /// Copies the current contents of the accumulator into the Y register and sets the zero and negative flags as appropriate.
        /// - Z - Zero Flag - Set if A = 0
        /// - N - Negative Flag - Set if bit 7 of A is set
        case TAY(TAY_OPCODE)

        /// TSX - Transfer Stack Pointer to X
        /// X = S
        /// Copies the current contents of the stack register into the X register and sets the zero and negative flags as appropriate..
        /// - Z - Zero Flag - Set if S = 0
        /// - N - Negative Flag - Set if bit 7 of S is set
        case TSX(TSX_OPCODE)

        /// TXA - Transfer X to Accumulator
        /// A = X
        /// Copies the current contents of the X register into the accumulator and sets the zero and negative flags as appropriate.
        /// - Z - Zero Flag - Set if X = 0
        /// - N - Negative Flag - Set if bit 7 of X is set
        case TXA(TXA_OPCODE)

        /// TXS - Transfer X to Stack Pointer
        /// SP = X
        /// Copies the current contents of the X register into the stack register.
        case TXS(TXS_OPCODE)

        /// TYA - Transfer Y to Accumulator
        /// A = Y
        /// Copies the current contents of the Y register into the accumulator and sets the zero and negative flags as appropriate.
        /// - Z - Zero Flag - Set if Y = 0
        /// - N - Negative Flag - Set if bit 7 of Y is set
        case TYA(TYA_OPCODE)

        /// Indefined instruction
        case undefined(Byte)

        init(byte: Byte) {
            switch byte {
            case 0x69, 0x65, 0x75, 0x6D, 0x7D, 0x79, 0x61, 0x71:
                self = .ADC(ADC_OPCODE(byte: byte))
            case 0x29, 0x25, 0x35, 0x2D, 0x3D, 0x39, 0x21, 0x31:
                self = .AND(AND_OPCODE(byte: byte))
            case 0x0A, 0x06, 0x16, 0x0E, 0x1E:
                self = .ASL(ASL_OPCODE(byte: byte))
            case 0x90:
                self = .BCC(BCC_OPCODE(byte: byte))
            case 0xB0:
                self = .BCS(BCS_OPCODE(byte: byte))
            case 0xF0:
                self = .BEQ(BEQ_OPCODE(byte: byte))
            case 0x24, 0x2C:
                self = .BIT(BIT_OPCODE(byte: byte))
            case 0x30:
                self = .BMI(BMI_OPCODE(byte: byte))
            case 0xD0:
                self = .BNE(BNE_OPCODE(byte: byte))
            case 0x10:
                self = .BPL(BPL_OPCODE(byte: byte))
            case 0x00:
                self = .BRK(BRK_OPCODE(byte: byte))
            case 0x50:
                self = .BVC(BVC_OPCODE(byte: byte))
            case 0x70:
                self = .BVS(BVS_OPCODE(byte: byte))
            case 0x18:
                self = .CLC(CLC_OPCODE(byte: byte))
            case 0xD8:
                self = .CLD(CLD_OPCODE(byte: byte))
            case 0x58:
                self = .CLI(CLI_OPCODE(byte: byte))
            case 0xB8:
                self = .CLV(CLV_OPCODE(byte: byte))
            case 0xC9, 0xC5, 0xD5, 0xCD, 0xDD, 0xD9, 0xC1, 0xD1:
                self = .CMP(CMP_OPCODE(byte: byte))
            case 0xE0, 0xE4, 0xEC:
                self = .CPX(CPX_OPCODE(byte: byte))
            case 0xC0, 0xC4, 0xCC:
                self = .CPY(CPY_OPCODE(byte: byte))
            case 0xC6, 0xD6, 0xCE, 0xDE:
                self = .DEC(DEC_OPCODE(byte: byte))
            case 0xCA:
                self = .DEX(DEX_OPCODE(byte: byte))
            case 0x88:
                self = .DEY(DEY_OPCODE(byte: byte))
            case 0x49, 0x45, 0x55, 0x4D, 0x5D, 0x59, 0x41, 0x51:
                self = .EOR(EOR_OPCODE(byte: byte))
            case 0xE6, 0xF6, 0xEE, 0xFE:
                self = .INC(INC_OPCODE(byte: byte))
            case 0xE8:
                self = .INX(INX_OPCODE(byte: byte))
            case 0xC8:
                self = .INY(INY_OPCODE(byte: byte))
            case 0x4C, 0x6C:
                self = .JMP(JMP_OPCODE(byte: byte))
            case 0x20:
                self = .JSR(JSR_OPCODE(byte: byte))
            case 0xA9, 0xA5, 0xB5, 0xAD, 0xBD, 0xB9, 0xA1, 0xB1:
                self = .LDA(LDA_OPCODE(byte: byte))
            case 0xA2, 0xA6, 0xB6, 0xAE, 0xBE:
                self = .LDX(LDX_OPCODE(byte: byte))
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
            case 0xE9, 0xE5, 0xF5, 0xED, 0xFD, 0xF9, 0xE1, 0xF1:
                self = .SBC(SBC_OPCODE(byte: byte))
            case 0x38:
                self = .SEC(SEC_OPCODE(byte: byte))
            case 0xF8:
                self = .SED(SED_OPCODE(byte: byte))
            case 0x78:
                self = .SEI(SEI_OPCODE(byte: byte))
            case 0x85, 0x95, 0x8D, 0x9D, 0x99, 0x81, 0x91:
                self = .STA(STA_OPCODE(byte: byte))
            case 0x86, 0x96, 0x8E:
                self = .STX(STX_OPCODE(byte: byte))
            case 0x84, 0x94, 0x8C:
                self = .STY(STY_OPCODE(byte: byte))
            case 0xAA:
                self = .TAX(TAX_OPCODE(byte: byte))
            case 0xA8:
                self = .TAY(TAY_OPCODE(byte: byte))
            case 0xBA:
                self = .TSX(TSX_OPCODE(byte: byte))
            case 0x8A:
                self = .TXA(TXA_OPCODE(byte: byte))
            case 0x9A:
                self = .TXS(TXS_OPCODE(byte: byte))
            case 0x98:
                self = .TYA(TYA_OPCODE(byte: byte))
            default:
                self = .undefined(byte)
            }
        }

        static var allCases: [any OPCODE.Type] {
            [
                ADC_OPCODE.self,
                AND_OPCODE.self,
                ASL_OPCODE.self,
                BCC_OPCODE.self,
                BCS_OPCODE.self,
                BEQ_OPCODE.self,
                BIT_OPCODE.self,
                BMI_OPCODE.self,
                BNE_OPCODE.self,
                BPL_OPCODE.self,
                BRK_OPCODE.self,
                BVC_OPCODE.self,
                BVS_OPCODE.self,
                CLC_OPCODE.self,
                CLD_OPCODE.self,
                CLI_OPCODE.self,
                CLV_OPCODE.self,
                CMP_OPCODE.self,
                CPX_OPCODE.self,
                CPY_OPCODE.self,
                DEC_OPCODE.self,
                DEX_OPCODE.self,
                DEY_OPCODE.self,
                EOR_OPCODE.self,
                INC_OPCODE.self,
                INX_OPCODE.self,
                INY_OPCODE.self,
                JMP_OPCODE.self,
                JSR_OPCODE.self,
                LDA_OPCODE.self,
                LDX_OPCODE.self,
                LDY_OPCODE.self,
                LSR_OPCODE.self,
                NOP_OPCODE.self,
                ORA_OPCODE.self,
                PHA_OPCODE.self,
                PHP_OPCODE.self,
                PLA_OPCODE.self,
                PLP_OPCODE.self,
                ROL_OPCODE.self,
                ROR_OPCODE.self,
                RTI_OPCODE.self,
                RTS_OPCODE.self,
                SBC_OPCODE.self,
                SEC_OPCODE.self,
                SED_OPCODE.self,
                SEI_OPCODE.self,
                STA_OPCODE.self,
                STX_OPCODE.self,
                STY_OPCODE.self,
                TAX_OPCODE.self,
                TAY_OPCODE.self,
                TSX_OPCODE.self,
                TXA_OPCODE.self,
                TXS_OPCODE.self,
                TYA_OPCODE.self
            ]
        }
    }
}
