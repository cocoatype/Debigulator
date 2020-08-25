//  Created by Geoff Pado on 8/24/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class ShortcutsPermissionsRestrictedAlertFactory: NSObject {
    static func alert() -> ShortcutsPermissionsRestrictedAlertController {
        let alertController = ShortcutsPermissionsRestrictedAlertController(title: ShortcutsPermissionsRestrictedAlertFactory.alertTitle, message: ShortcutsPermissionsRestrictedAlertFactory.alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = .controlTint

        alertController.addAction(dismissAction)

        return alertController
    }

    private static let dismissAction = UIAlertAction(title: ShortcutsPermissionsRestrictedAlertFactory.dismissButtonTitle, style: .cancel, handler: nil)

    // MARK: Localized Strings

    private static let alertTitle = NSLocalizedString("ShortcutsPermissionsRestrictedAlertController.alertTitle", comment: "Title for the Shortcuts permissions restricted alert")
    private static let alertMessage = NSLocalizedString("ShortcutsPermissionsRestrictedAlertController.alertMessage", comment: "Message for the Shortcuts permissions restricted alert")
    private static let dismissButtonTitle = NSLocalizedString("ShortcutsPermissionsRestrictedAlertController.dismissButtonTitle", comment: "Title for the cancel button on the Shortcuts permissions restricted alert")
}

class ShortcutsPermissionsRestrictedAlertController: UIAlertController {}

class AlertEvent: UIEvent {
    init(alert: UIAlertController) {
        self.alert = alert
        super.init()
    }

    let alert: UIAlertController
}
