/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************
 *  This file contains code that has not yet been described                   *
 ******************************************************************************/

@_exported import class Foundation.Pipe
@_exported import class Foundation.FileHandle

import struct Foundation.Data

public enum CommunicationChannel {
    case pipe(Pipe)
    case fileHandle(FileHandle)

    public func readAllText() -> String {
        switch self {
        case .pipe(let pipe): return pipe.readAllText()
        case .fileHandle(let handle): return handle.readAllText()
        }
    }

    public var availableData: Data {
        switch self {
        case .pipe(let pipe): return pipe.availableData
        case .fileHandle(let handle): return handle.availableData
        }
    }
}

extension FileHandle {
    public func readAllText() -> String {
        let offset = self.offsetInFile
        self.seek(toFileOffset: 0)
        let data = self.readDataToEndOfFile()
        self.seek(toFileOffset: offset)
        guard let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Pipe {
    public func readAllText() -> String {
        let data = self.fileHandleForReading.readDataToEndOfFile()
        guard let string = String(data: data, encoding: .utf8) else {
            return ""
        }
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var availableData: Data {
        return fileHandleForReading.availableData
    }
}
