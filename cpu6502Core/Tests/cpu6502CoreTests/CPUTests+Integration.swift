import XCTest

@testable import cpu6502Core

final class CPUIntegrationTests: XCTestCase {
    private var cpu: CPU!
    private var memory: Memory!

    func testIntegration() throws {
        var cpu = CPU()
        var memory = Memory()

        // load hex
        let filePath = Bundle.module.path(forResource: "Integration", ofType: "hex")!
        let fileData = try String(contentsOfFile: filePath, encoding: .ascii)
        try cpu.load(
            data: fileData,
            to: &memory)

        // initial program counter
        cpu.PC = 0x0400

        var lastPC = cpu.PC
        while true {

            // next step
            _ = try cpu.execute(
                memory: &memory,
                cycles: 1)

            if cpu.PC == 0x3443 {
                // success
                return
            }

            if cpu.PC == lastPC {
                XCTFail("Integration failed: \(lastPC.hex)")
                return
            }

            lastPC = cpu.PC
        }
    }
}
