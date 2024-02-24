public struct Memory {
    public static let SIZE: Word = 0xFFFF

    private var data: [Byte] = [Byte](repeating: 0, count: Int(Memory.SIZE))

    public init() { /* public init */ }

    internal init(_ data: [Byte]) {
        self.data = data
    }

    public subscript(_ address: Word) -> Byte {
        get { data[Int(address)] }
        set { data[Int(address)] = newValue }
    }

    mutating public func reset() {
        data = [Byte](repeating: 0, count: Int(Memory.SIZE))
    }
}
