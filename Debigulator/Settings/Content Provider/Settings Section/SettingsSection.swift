//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

struct SettingsSection: SettingsContentSection {
    var header: String? { return nil }

    var items: [SettingsContentItem] {
        var items = [SettingsContentItem]()

        if ShortcutsPermissionsRequester().authorizationStatus != .authorized {
            items.append(ShortcutsItem())
        }

        return items
    }
}
