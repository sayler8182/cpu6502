internal extension CPU {
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
                let (_, cycles, additionalCycles) = try executor.execute(
                    cpu: &self,
                    memory: &memory,
                    instruction: Instruction(byte: instruction)
                )

                // add opcode cycles
                totalCycles += cycles

                // add page cross
                totalCycles += additionalCycles
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
}

internal extension CPU {
    func address(
        of address: Word,
        from memory: Memory
    ) -> Word {
        isLittleEndian
        ? Word(memory[address]) | (Word(memory[address + 1]) << 8)
        : (Word(memory[address]) << 8) | Word(memory[address + 1])
    }

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
                let address = Word(byte &+ (registers.X))
                return address
            case .zeroPageY(let byte):
                let address = Word(byte &+ (registers.Y))
                return address
            case .relative(let byte):
                let address = Word(byte)
                return address
            case .absolute(let word):
                let address = word
                return address
            case .absoluteX(let word):
                let address = word &+ Word(registers.X)
                return address
            case .absoluteY(let word):
                let address = word &+ Word(registers.Y)
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
    ) throws -> (data: Byte, additionalCycles: Cycles) {
        switch mode {
        case .accumulator:
            return (registers.A, 0)
        case .immediate(let byte):
            return (byte, 0)
        case .zeroPage(let byte):
            let address = Word(byte)
            return (memory[address], 0)
        case .zeroPageX(let byte):
            let address = Word(byte &+ (registers.X))
            return (memory[address], 0)
        case .zeroPageY(let byte):
            let address = Word(byte &+ (registers.Y))
            return (memory[address], 0)
        case .absolute(let word):
            return (memory[word], 0)
        case .absoluteX(let word):
            let address = word
            let addressWithOffset = address &+ Word(registers.X)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 1)
            } else {
                return (memory[addressWithOffset], 0)
            }
        case .absoluteY(let word):
            let address = word
            let addressWithOffset = address &+ Word(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 1)
            } else {
                return (memory[addressWithOffset], 0)
            }
        case .indirect(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            return (memory[address], 0)
        case .indirectX(let word):
            var address = (word + Word(registers.X)) & 0xFF
            address = isLittleEndian
            ? Word(memory[address]) | (Word(memory[address + 1]) << 8)
            : (Word(memory[address]) << 8) | Word(memory[address + 1])
            return (memory[address], 0)
        case .indirectY(let word):
            let address = isLittleEndian
            ? Word(memory[word]) | (Word(memory[word + 1]) << 8)
            : (Word(memory[word]) << 8) | Word(memory[word + 1])
            let addressWithOffset = address + Word(registers.Y)
            // crossing page
            if (address ^ addressWithOffset) >> 8 != 0 {
                return (memory[addressWithOffset], 1)
            } else {
                return (memory[addressWithOffset], 0)
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

    mutating func push(
        byte: Byte,
        to memory: inout Memory
    ) throws {
        let address = 0x0100 | Word(SP)
        memory[address] = byte
        SP = SP &- (Byte(1))
    }

    mutating func push(
        word: Word,
        to memory: inout Memory
    ) throws {
        if isLittleEndian {
            try push(byte: Byte((word >> 8) & 0xFF), to: &memory)
            try push(byte: Byte(word & 0xFF), to: &memory)
        } else {
            try push(byte: Byte(word & 0xFF), to: &memory)
            try push(byte: Byte((word >> 8) & 0xFF), to: &memory)
        }
    }

    mutating func pull(
        from memory: inout Memory
    ) throws -> Byte {
        SP = SP &+ (Byte(1))
        let address = 0x0100 | Word(SP)
        let byte = memory[address]
        return byte
    }

    mutating func pull(
        from memory: inout Memory
    ) throws -> Word {
        if isLittleEndian {
            let low: Byte = try pull(from: &memory)
            let high: Byte = try pull(from: &memory)
            return Word(low) | (Word(high) << 8)
        } else {
            let high: Byte = try pull(from: &memory)
            let low: Byte = try pull(from: &memory)
            return Word(low) | (Word(high) << 8)
        }
    }
}
