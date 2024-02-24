internal extension Byte {
    var hex: String {
        var value = String(self, radix: 16)
        while value.count < 2 { value = "0" + value }
        return String(format: "0x%@", value)
    }
}

internal extension Word {
    var hex: String {
        var value = String(self, radix: 16)
        while value.count < 4 { value = "0" + value }
        return String(format: "0x%@", value)
    }
}
