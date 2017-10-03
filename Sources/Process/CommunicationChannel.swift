/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Foundation

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
