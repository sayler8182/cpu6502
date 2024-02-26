extension CPU {
    public struct StatusFlags: CustomDebugStringConvertible {
        public enum Flag: Byte, CustomDebugStringConvertible {
            /// Negative
            case N = 7
            /// Overflow
            case V = 6
            /// Break
            case B = 4
            /// Decimal mode
            case D = 3
            /// Interrupt disable
            case I = 2
            /// Zero Flag
            case Z = 1
            /// Carry Flag
            case C = 0

            public var debugDescription: String {
                switch self {
                case .N: return "N"
                case .V: return "V"
                case .B: return "B"
                case .D: return "D"
                case .I: return "I"
                case .Z: return "Z"
                case .C: return "C"
                }
            }
        }

        public var value: Byte = 0x0

        /// Negative
        public var N: Bool {
            get { self[.N] }
            set { self[.N] = newValue }
        }
        /// Overflow
        public var V: Bool {
            get { self[.V] }
            set { self[.V] = newValue }
        }
        /// Break
        public var B: Bool {
            get { self[.B] }
            set { self[.B] = newValue }
        }
        /// Decimal mode
        public var D: Bool {
            get { self[.D] }
            set { self[.D] = newValue }
        }
        /// Interrupt disable
        public var I: Bool {
            get { self[.I] }
            set { self[.I] = newValue }
        }
        /// Zero Flag
        public var Z: Bool {
            get { self[.Z] }
            set { self[.Z] = newValue }
        }
        /// Carry Flag
        public var C: Bool {
            get { self[.C] }
            set { self[.C] = newValue }
        }

        public var debugDescription: String {
            """
            N: \(self[.N] ? "1" : "0")
            V: \(self[.V] ? "1" : "0")
            B: \(self[.B] ? "1" : "0")
            D: \(self[.D] ? "1" : "0")
            I: \(self[.I] ? "1" : "0")
            Z: \(self[.Z] ? "1" : "0")
            C: \(self[.C] ? "1" : "0")
            """
        }

        public init( _ value: Byte) {
            self.value = value
        }

        public init(_ flags: [Flag]) {
            self.value = 0
            for flag in flags {
                self[flag] = true
            }

        }

        public subscript(_ flag: Flag) -> Byte {
            value & (1 << flag.rawValue)
        }

        public subscript(_ flag: Flag) -> Bool {
            get { (value & (1 << flag.rawValue)) != 0 }
            set {
                if newValue {
                    value = value | (1 << flag.rawValue)
                } else {
                    value = value & ~(1 << flag.rawValue)
                }
            }
        }
    }
}

internal extension CPU.StatusFlags {
    mutating func setNegative(_ value: Byte) {
        self[.N] = (value & (1 << Flag.N.rawValue)) != 0
    }

    mutating func setZero(_ value: Byte) {
        self[.Z] = value == 0
    }
}
