public struct Memory {
    public static let SIZE: Int = 0xFFFF + 1

    private var data: [Byte] = [Byte](repeating: 0, count: Memory.SIZE)

    public init() { /* public init */ }

    internal init(_ data: [Byte]) {
        self.data = data
    }

    public subscript(_ address: Word) -> Byte {
        get { data[Int(address)] }
        set { data[Int(address)] = newValue }
    }

    mutating public func reset() {
        data = [Byte](repeating: 0, count: Memory.SIZE)
    }

    var hex: String {
        var result: String = ""
        for i in 0..<Memory.SIZE {
            result += "\(Word(i).hex): \(self[Word(i)].hex)\n"
        }
        return result
    }
}
