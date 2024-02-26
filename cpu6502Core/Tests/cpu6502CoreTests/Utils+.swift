@testable import cpu6502Core

extension Byte {
    static var random: Byte {
        (0...0xFF).randomElement()!
    }
}

extension Word {
    static var random: Word {
        (0...0xFFFF).randomElement()!
    }
}

extension Memory {
    static var random: Memory {
        var data = [Byte](repeating: 0, count: Int(Memory.SIZE))
        for i in 0..<Int(Memory.SIZE) {
            data[i] = .random
        }
        return Memory(data)
    }
}

extension CPU.StatusFlags {
    static var random: CPU.StatusFlags {
        CPU.StatusFlags(.random)
    }
}

extension CPU.Registers {
    static var random: CPU.Registers {
        CPU.Registers(
            A: .random,
            X: .random,
            Y: .random
        )
    }
}
