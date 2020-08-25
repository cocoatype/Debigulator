//  Created by Geoff Pado on 8/24/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Foundation
import Intents

class ShortcutsPermissionsRequester: NSObject {
    var authorizationStatus: INSiriAuthorizationStatus {
        INPreferences.siriAuthorizationStatus()
    }

    func requestAuthorization(handler: @escaping ((INSiriAuthorizationStatus) -> Void)) {
        INPreferences.requestSiriAuthorization { status in
            DispatchQueue.main.async {
                handler(status)
            }
        }
    }
}
