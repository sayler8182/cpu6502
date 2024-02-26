internal extension Byte {
    var hex: String {
        var value = String(self, radix: 16)
        while value.count < 2 { value = "0" + value }
        return String(format: "0x%@", value)
    }

    var binary: String {
        var value = String(self, radix: 2)
        while value.count < 8 { value = "0" + value }
        return String(format: "0b%@", value)
    }
}

internal extension Word {
    var hex: String {
        var value = String(self, radix: 16)
        while value.count < 4 { value = "0" + value }
        return String(format: "0x%@", value)
    }

    var binary: String {
        var value = String(self, radix: 2)
        while value.count < 16 { value = "0" + value }
        return String(format: "0b%@", value)
    }
}
