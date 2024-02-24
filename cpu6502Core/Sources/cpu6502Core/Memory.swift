import Foundation

private let MEMORY_SIZE: Address = 0xFFFF

public struct Memory {
    private var data: [Byte] = [Byte](repeating: 0, count: Int(MEMORY_SIZE))

    subscript(_ address: Address) -> Byte {
        get { data[Int(address)] }
        set { data[Int(address)] = newValue }
    }
}
