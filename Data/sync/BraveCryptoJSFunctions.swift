// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import Foundation
import BraveShared

struct BraveCryptoJSFunctions: BrowserifyExposable, BundledJSProtocol {
    let bundle: Bundle
    let name: String
    let exposedFunctions: [ExposedJSFunction]
    
    struct Names {
        static let fromBytesOrHex = "fromBytesOrHex"
        static let toBytes32 = "toBytes32"
    }
    
    init?() {
        name = "crypto"
        bundle = Bundle.data
        
        exposedFunctions = [ExposedJSFunction(name: Names.fromBytesOrHex, body: Bodies.fromBytesOrHex),
                            ExposedJSFunction(name: Names.toBytes32, body: Bodies.toBytes32)]
    }
    
    private struct Bodies {
        static let fromBytesOrHex =
        """
        function(bytes){
           return module.exports.passphrase.fromBytesOrHex(bytes);
        };
        """
        
        static let toBytes32 =
        """
        function(passphrase){
           return module.exports.passphrase.toBytes32(passphrase);
        };
        """
    }
}
