// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import JavaScriptCore

public struct JSError: Error, CustomStringConvertible {
    let exception: String
    public var description: String { return exception }
    
    init(_ exception: String) {
        self.exception = exception
    }
    
    public static var unknownError: JSError {
        return JSError("Unknown error")
    }
}
