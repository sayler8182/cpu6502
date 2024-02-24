public extension CPU {
    /// Executes program in memory
    /// - Throws: CPUError
    /// - Returns: Spend cycles
    mutating func execute(memory: inout Memory,
                          cycles: Cycles) throws -> Cycles {
        var totalCycles: Cycles = 0
        let executor: Executor = Executor()

        while totalCycles < cycles {
            let instruction: Byte = memory[PC]
            totalCycles += 1
            do {
                totalCycles += try executor.execute(
                    cpu: &self,
                    memory: &memory,
                    instruction: Instruction(byte: instruction)
                )
                return totalCycles
            } catch let error as ExecutorError {
                switch error {
                case .undefinedInstruction(let byte):
                    throw CPUError.undefinedInstruction(byte)
                case .unimplemented(let byte):
                    throw CPUError.unimplemented(byte)
                }
            }
        }

        return totalCycles
    }

    mutating func moveProgramCounter(_ size: Byte) {
        PC += Word(size)
    }
}

extension CPU {
    func read(from memory: Memory,
              for mode: CPU.AddressingMode) throws -> (data: Byte, cycles: Cycles) {
        switch mode {
        case .accumulator:
            return (registers.A, 1)
        case .immediate(let byte):
            return (byte, 1)
        case .zeroPage(let byte):
            let address = Word(byte)
            return (memory[address], 2)
        case .zeroPageX(let byte):
            let address = Word(byte.addingWithOverflow(registers.X))
            return (memory[address], 3)
        case .zeroPageY(let byte):
            let address = Word(byte.addingWithOverflow(registers.Y))
            return (memory[address], 3)
        case .absolute(let word):
            return (memory[word], 3)
        case .absoluteX(let word):
            let address = word
            let addressWithOffset = address.addingWithOverflow(registers.X)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 4)
            } else {
                return (memory[addressWithOffset], 3)
            }
        case .absoluteY(let word):
            let address = word
            let addressWithOffset = address.addingWithOverflow(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 4)
            } else {
                return (memory[addressWithOffset], 3)
            }
        case .indirect(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            return (memory[address], 5)
        case .indirectX(let word):
            var address = (word + Word(registers.X)) & 0xFF
            address = isLittleEndian
            ? Word(memory[address]) | (Word(memory[address + 1]) << 8)
            : (Word(memory[address]) << 8) | Word(memory[address + 1])
            return (memory[address], 5)
        case .indirectY(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            let addressWithOffset = address + Word(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 5)
            } else {
                return (memory[addressWithOffset], 4)
            }
        default:
            throw CPUError.incorrectAddressingMode(mode)
        }
    }
}
