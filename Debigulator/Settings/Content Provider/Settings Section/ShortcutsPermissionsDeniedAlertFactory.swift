//  Created by Geoff Pado on 8/24/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class ShortcutsPermissionsDeniedAlertFactory: NSObject {
    static func alert() -> ShortcutsPermissionsDeniedAlertController {
        let alertController = ShortcutsPermissionsDeniedAlertController(title: ShortcutsPermissionsDeniedAlertFactory.alertTitle, message: ShortcutsPermissionsDeniedAlertFactory.alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = .controlTint

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        return alertController
    }

    private static let settingsAction = UIAlertAction(title: ShortcutsPermissionsDeniedAlertFactory.actionButtonTitle, style: .default, handler: { _ in
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    })
    private static let cancelAction = UIAlertAction(title: ShortcutsPermissionsDeniedAlertFactory.cancelButtonTitle, style: .cancel, handler: nil)

    // MARK: Localized Strings

    private static let alertTitle = NSLocalizedString("ShortcutsPermissionsDeniedAlertController.alertTitle", comment: "Title for the shortcuts permissions denied alert")
    private static let alertMessage = NSLocalizedString("ShortcutsPermissionsDeniedAlertController.alertMessage", comment: "Message for the shortcuts permissions denied alert")
    private static let actionButtonTitle = NSLocalizedString("ShortcutsPermissionsDeniedAlertController.actionButtonTitle", comment: "Title for the settings button on the shortcuts permissions denied alert")
    private static let cancelButtonTitle = NSLocalizedString("ShortcutsPermissionsDeniedAlertController.cancelButtonTitle", comment: "Title for the cancel button on the shortcuts permissions denied alert")
}

class ShortcutsPermissionsDeniedAlertController: UIAlertController {}
