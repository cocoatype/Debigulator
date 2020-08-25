//  Created by Geoff Pado on 8/24/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Intents
import UIKit

struct ShortcutsItem: StandardContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.shortcuts", comment: "Title for the shortcuts settings item")
    let subtitle = String?.none

    private func displayAlert(_ alert: UIAlertController, sender: Any) {
        let event = AlertEvent(alert: alert)
        UIApplication.shared.sendAction(#selector(SettingsViewController.displayAlert(_:event:)), to: nil, from: sender, for: event)
    }

    func performSelectedAction(_ sender: Any) {
        Self.requester.requestAuthorization { status in
            switch status {
            case .authorized:
                let intent = DebigulateImageIntent()
                let shortcut = INShortcut(intent: intent)
                INVoiceShortcutCenter.shared.setShortcutSuggestions([shortcut!])
                UIApplication.shared.sendAction(#selector(SettingsViewController.reloadSettingsSection), to: nil, from: sender, for: nil)
            case .denied:
                displayAlert(ShortcutsPermissionsDeniedAlertFactory.alert(), sender: sender)
            case .restricted:
                displayAlert(ShortcutsPermissionsRestrictedAlertFactory.alert(), sender: sender)
            case .notDetermined: fallthrough
            @unknown default: break
            }
        }
    }

    private static let requester = ShortcutsPermissionsRequester()
}
