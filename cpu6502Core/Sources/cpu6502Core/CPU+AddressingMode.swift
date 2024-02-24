public extension CPU {
    enum AddressingMode {
        case accumulator
        case implicit
        case immediate(Byte)
        case zeroPage(Byte)
        case zeroPageX(Byte)
        case zeroPageY(Byte)
        case relative(Byte)
        case absolute(Word)
        case absoluteX(Word)
        case absoluteY(Word)
        case indirect(Word)
        case indirectX(Word)
        case indirectY(Word)
    }

    func addressingMode(from mode: Instruction.AddressingMode,
                        memory: Memory,
                        size: Byte) -> AddressingMode {
        switch mode {
        case .implicit:
            return AddressingMode.implicit
        case .accumulator:
            return AddressingMode.accumulator
        case .immediate:
            let byte = memory[PC + 1]
            return AddressingMode.immediate(byte)
        case .zeroPage:
            let byte = memory[PC + 1]
            return AddressingMode.zeroPage(byte)
        case .zeroPageX:
            let byte = memory[PC + 1]
            return AddressingMode.zeroPageX(byte)
        case .zeroPageY:
            let byte = memory[PC + 1]
            return AddressingMode.zeroPageY(byte)
        case .relative:
            let byte = memory[PC + 1]
            return AddressingMode.relative(byte)
        case .absolute:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.absolute(word)
        case .absoluteX:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.absoluteX(word)
        case .absoluteY:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.absoluteY(word)
        case .indirect:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.indirect(word)
        case .indirectX where size == 2:
            let word =  Word(memory[PC + 1])
            return AddressingMode.indirectX(word)
        case .indirectX:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.indirectX(word)
        case .indirectY where size == 2:
            let word = Word(memory[PC + 1])
            return AddressingMode.indirectY(word)
        case .indirectY:
            let word = Word(memory[PC + 1]) | (Word(memory[PC + 2]) << 8)
            return AddressingMode.indirectY(word)
        }
    }
}
