import Foundation

public enum CPULoadError: Error, CustomDebugStringConvertible {
    case incorrectHexFormat([String])
    case incorrectCharacters(String)
    case incorrectRecordSize(String)
    case unexpected(Error)

    public var debugDescription: String {
        switch self {
        case .incorrectHexFormat(let lines):
            return "CPULoadError - incorrect hex format: '\(lines)'"
        case .incorrectCharacters(let line):
            return "CPULoadError - incorrect characters: '\(line)'"
        case .incorrectRecordSize(let line):
            return "CPULoadError - incorrect record size: '\(line)'"
        case .unexpected(let error):
            return "CPULoadError - unexpected error: '\(error)'"
        }
    }
}

public extension CPU {
    private struct LoadRecord {
        let byteCount: Byte
        let address: Word
        let recordType: Byte
        let data: [Byte]
        let checksum: Byte
    }

    /// Loads program to memory
    /// - Throws: CPULoadError
    func load(
        data: String,
        to memory: inout Memory
    ) throws {
        let lines = data
            .replacingOccurrences(of: "\r", with: "")
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        if lines.contains(where: { !$0.hasPrefix(":") }) {
            let incorrectLines = lines.filter { !$0.hasPrefix(":") }
            throw CPULoadError.incorrectHexFormat(incorrectLines)
        }

        var records: [LoadRecord] = []

        for line in lines {
            let line = String(line.dropFirst())
            let bytes = try lineToBytes(line: line)

            let byteCount = bytes[0]
            let address = (Word(bytes[1]) << 8) | Word(bytes[2])
            let recordType = bytes[3]
            let data = [Byte](bytes[4..<bytes.count - 1])
            let checksum = bytes[bytes.count - 1]

            let record = LoadRecord(
                byteCount: byteCount,
                address: address,
                recordType: recordType,
                data: data,
                checksum: checksum)
            records.append(record)
        }

        try load(
            records: records,
            to: &memory)
    }

    /// Loads program to memory
    /// - Throws: CPULoadError
    private func load(
        records: [LoadRecord],
        to memory: inout Memory
    ) throws {
        let records = records.filter { $0.recordType == 0x00 }
        for record in records {
            var address = record.address
            for byte in record.data {
                memory[address] = byte
                address = address &+ (Word(1))
            }
        }
    }

    /// Loads program to memory
    /// - Throws: CPULoadError
    private func lineToBytes(line: String) throws -> [Byte] {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-f]*$", options: .caseInsensitive)
            let range = NSRange(location: 0, length: line.utf16.count)
            guard let match = regex.firstMatch(in: line, options: [], range: range),
                  match.range.location != NSNotFound else {
                throw CPULoadError.incorrectCharacters(line)
            }

            if !line.count.isMultiple(of: 2) {
                throw CPULoadError.incorrectRecordSize(line)
            }

            var data: [Byte] = []
            var index = line.startIndex

            while index < line.endIndex {
                let byteString = line[index..<line.index(index, offsetBy: 2)]
                let byte = Byte(byteString, radix: 16)!
                data.append(byte)
                index = line.index(index, offsetBy: 2)
            }

            if data.count < 4 {
                throw CPULoadError.incorrectRecordSize(line)
            }

            return data
        } catch let error as CPULoadError {
            throw error
        } catch {
            throw CPULoadError.unexpected(error)
        }
    }
}
