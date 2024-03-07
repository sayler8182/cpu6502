public struct Memory {
    private let size: Int
    private var data: [Byte]

    public init(size: Int = 0x10000) {
        self.size = size
        self.data = [Byte](repeating: 0, count: size)
    }

    internal init(_ data: [Byte]) {
        self.size = data.count
        self.data = data
    }

    public subscript(_ address: Word) -> Byte {
        get { data[Int(address)] }
        set { data[Int(address)] = newValue }
    }

    mutating public func reset() {
        data = [Byte](repeating: 0, count: size)
    }

    var hex: String {
        var result: String = ""
        for i in 0..<size {
            result += "\(Word(i).hex): \(self[Word(i)].hex)\n"
        }
        return result
    }
}
