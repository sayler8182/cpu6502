import Foundation

public enum CPUError: Error, CustomDebugStringConvertible {
    case undefinedInstruction(Byte)
    case unimplemented(Byte)
    case incorrectAddressingMode(CPU.AddressingMode)

    public var debugDescription: String {
        switch self {
        case .undefinedInstruction(let byte):
            return String(format: "CPUError - undefined instruction: '0x%@'", String(byte, radix: 16).uppercased())
        case .unimplemented(let byte):
            return String(format: "CPUError - unimplemented instruction: '0x%@'", String(byte, radix: 16).uppercased())
        case .incorrectAddressingMode(let mode):
            return String(format: "CPUError - incorrect addressingMode for mode: '\(mode)'")
        }
    }
}

public struct CPU {
    public static let START_PC: Word = 0xFFFC
    public static let START_SP: Byte = 0xFF
    public static let START_SP_FIRST_PAGE: Word = 0x01FF

    public struct Registers {
        public var A: Byte
        public var X: Byte
        public var Y: Byte
    }

    public var isLittleEndian: Bool = true

    /// Program Counter
    public var PC: Word

    /// Stack pointer
    public var SP: Byte

    /// Status Flags
    public var flags: StatusFlags

    /// Registers: A, X, Y
    public var registers: Registers

    public init() {
        PC = CPU.START_PC
        SP = CPU.START_SP
        flags = StatusFlags(0x00)
        registers = Registers(
            A: 0x00,
            X: 0x00,
            Y: 0x00
        )
    }

    mutating public func reset() {
        PC = CPU.START_PC
        SP = CPU.START_SP
        flags = StatusFlags(0x00)
        registers = Registers(
            A: 0x00,
            X: 0x00,
            Y: 0x00
        )
    }
}
