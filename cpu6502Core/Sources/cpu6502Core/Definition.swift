public typealias Byte = UInt8
public typealias Word = UInt16
public typealias Cycles = Int16

internal extension Byte {
    /// Wraps value if overflow
    /// - returns: Overflow status
    func addingWithOverflow(_ value: Byte) -> Byte {
        let result = addingReportingOverflow(value)
        return result.partialValue
    }

    /// Wraps value if overflow
    /// - returns: Overflow status
    func subtractingWithOverflow(_ value: Byte) -> Byte {
        let result = subtractingReportingOverflow(value)
        return result.partialValue
    }
}

internal extension Word {
    /// Wraps value if overflow
    /// - returns: Overflow status
    func addingWithOverflow(_ value: Byte) -> Word {
        let result = addingReportingOverflow(Word(value))
        return result.partialValue
    }

    /// Wraps value if overflow
    /// - returns: Overflow status
    func addingWithOverflow(_ value: Word) -> Word {
        let result = addingReportingOverflow(Word(value))
        return result.partialValue
    }

    /// Wraps value if overflow
    /// - returns: Overflow status
    func subtractingWithOverflow(_ value: Byte) -> Word {
        let result = subtractingReportingOverflow(Word(value))
        return result.partialValue
    }

    /// Wraps value if overflow
    /// - returns: Overflow status
    func subtractingWithOverflow(_ value: Word) -> Word {
        let result = subtractingReportingOverflow(value)
        return result.partialValue
    }
}
