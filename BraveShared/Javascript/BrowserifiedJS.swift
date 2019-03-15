// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import JavaScriptCore

public typealias BundledBrowserifiedScript = BrowserifyExposable & BundledJSProtocol

/// A wrapper around `JSContext` to help with browserified code.
public class BrowserifiedJS {
    public let context: JSContext
    
    public init?(browserifiedScript script: BundledBrowserifiedScript?) {
        context = JSContext()
        
        guard let script = script, let scriptString = script.get else { return nil }
        let src = "var window = this; \(scriptString)"
        context.evaluateScript(src)
        
        script.addExposedFunctions(to: context)
    }
    
    public func callFunction(withName functionName: String, arguments: [Any]) throws -> JSValue {
        guard let function = context.globalObject.objectForKeyedSubscript(functionName) else {
            throw JSError("Error: could not invoke \(functionName) javascript function")
        }

        return try function.tryToCall(withArguments: arguments)
    }
}
