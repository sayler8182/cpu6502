public extension CPU {
    /// Executes program in memory
    /// - Throws: CPUError
    /// - Returns: Spend cycles
    mutating func execute(
        memory: inout Memory,
        cycles: Cycles
    ) throws -> Cycles {
        var totalCycles: Cycles = 0
        let executor: Executor = Executor()

        while totalCycles < cycles {
            let instruction: Byte = memory[PC]

            do {
                let (size, cycles, isCrossed) = try executor.execute(
                    cpu: &self,
                    memory: &memory,
                    instruction: Instruction(byte: instruction)
                )

                // add opcode cycles
                totalCycles += cycles

                // add page cross
                if isCrossed {
                    totalCycles += 1
                }

                // move program counter
                moveProgramCounter(size)

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
    func address(
        from memory: Memory,
        for mode: CPU.AddressingMode
    ) throws -> Word {
            switch mode {
            case .accumulator:
                throw CPUError.incorrectAddressingMode(mode)
            case .immediate(let byte):
                let address = Word(byte)
                return address
            case .zeroPage(let byte):
                let address = Word(byte)
                return address
            case .zeroPageX(let byte):
                let address = Word(byte.addingWithOverflow(registers.X))
                return address
            case .zeroPageY(let byte):
                let address = Word(byte.addingWithOverflow(registers.Y))
                return address
            case .relative(let byte):
                let address = Word(byte)
                return address
            case .absolute(let word):
                let address = word
                return address
            case .absoluteX(let word):
                let address = word.addingWithOverflow(registers.X)
                return address
            case .absoluteY(let word):
                let address = word.addingWithOverflow(registers.Y)
                return address
            case .indirect(let word):
                let address = isLittleEndian
                ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
                : (Word(memory[word]) << 8) | Word(memory[word + 1])
                return address
            case .indirectX(let word):
                var address = (word + Word(registers.X)) & 0xFF
                address = isLittleEndian
                ? Word(memory[address]) | (Word(memory[address + 1]) << 8)
                : (Word(memory[address]) << 8) | Word(memory[address + 1])
                return address
            case .indirectY(let word):
                let address = isLittleEndian
                ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
                : (Word(memory[word]) << 8) | Word(memory[word + 1])
                let addressWithOffset = address + Word(registers.Y)
                return addressWithOffset
            default:
                throw CPUError.incorrectAddressingMode(mode)
            }
        }

    func read(
        from memory: Memory,
        for mode: CPU.AddressingMode
    ) throws -> (data: Byte, isCrossed: Bool) {
        switch mode {
        case .accumulator:
            return (registers.A, false)
        case .immediate(let byte):
            return (byte, false)
        case .zeroPage(let byte):
            let address = Word(byte)
            return (memory[address], false)
        case .zeroPageX(let byte):
            let address = Word(byte.addingWithOverflow(registers.X))
            return (memory[address], false)
        case .zeroPageY(let byte):
            let address = Word(byte.addingWithOverflow(registers.Y))
            return (memory[address], false)
        case .absolute(let word):
            return (memory[word], false)
        case .absoluteX(let word):
            let address = word
            let addressWithOffset = address.addingWithOverflow(registers.X)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], true)
            } else {
                return (memory[addressWithOffset], false)
            }
        case .absoluteY(let word):
            let address = word
            let addressWithOffset = address.addingWithOverflow(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], true)
            } else {
                return (memory[addressWithOffset], false)
            }
        case .indirect(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            return (memory[address], false)
        case .indirectX(let word):
            var address = (word + Word(registers.X)) & 0xFF
            address = isLittleEndian
            ? Word(memory[address]) | (Word(memory[address + 1]) << 8)
            : (Word(memory[address]) << 8) | Word(memory[address + 1])
            return (memory[address], false)
        case .indirectY(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            let addressWithOffset = address + Word(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], true)
            } else {
                return (memory[addressWithOffset], false)
            }
        default:
            throw CPUError.incorrectAddressingMode(mode)
        }
    }

    mutating func write(
        byte: Byte,
        to memory: inout Memory,
        for mode: CPU.AddressingMode
    ) throws {
        if case .accumulator = mode {
            registers.A = byte
        } else {
            let address = try address(
                from: memory,
                for: mode)
            memory[address] = byte
        }

    }
}
