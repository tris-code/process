import XCTest

extension ProcessTests {
    static let __allTests = [
        ("testByName", testByName),
        ("testByPath", testByPath),
        ("testExitTimeout", testExitTimeout),
        ("testFileChannel", testFileChannel),
        ("testStatus", testStatus),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ProcessTests.__allTests),
    ]
}
#endif
