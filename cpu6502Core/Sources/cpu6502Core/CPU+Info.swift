import Foundation

public extension CPU {
    var supportedInstructionInfo: String {
        var result = """
        Supported instructions:\n
        """

        let opcodes = CPU.Instruction.allCases
        for opcode in opcodes {
            result += "\(opcode.info)\n"
        }

        return result
    }
}
