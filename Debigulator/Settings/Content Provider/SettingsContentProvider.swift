//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class SettingsContentProvider: NSObject {
    // MARK: Data

    func sectionIndex(for sectionType: SettingsContentSection.Type) -> Int? {
        return sections.firstIndex(where: { type(of: $0) == sectionType })
    }

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(inSectionAtIndex index: Int) -> Int {
        return sections[index].items.count
    }

    func section(at index: Int) -> SettingsContentSection {
        return sections[index]
    }

    func item(at indexPath: IndexPath) -> SettingsContentItem {
        return sections[indexPath.section].items[indexPath.row]
    }

    // MARK: Other Apps

    private let otherAppEntries: [AppEntry] = [
        AppEntry(name: "Kineo", subtitle: "Draw flipbook-style animations", icon: #imageLiteral(resourceName: "Kineo"), appStoreURL: URL(string: "https://apps.apple.com/us/app/kineo/id286948844?ls=1"), bundleID: "com.flipbookapp.flickbook"),
        AppEntry(name: "Black Highlighter", subtitle: "Share pictures, not secrets", icon: #imageLiteral(resourceName: "Highlighter.png"), appStoreURL: URL(string: "https://apps.apple.com/us/app/black-highlighter/id1215283742?uo=4"), bundleID: "com.cocoatype.Highlighter"),
        AppEntry(name: "Scrawl Notes", subtitle: "definitely an app", icon: #imageLiteral(resourceName: "Scrawl"), appStoreURL: URL(string: "https://apps.apple.com/us/app/scrawl-notes/id1229326968?uo=4"), bundleID: "com.cocoatype.Scratch")
    ]

    // MARK: Notifications

    static let didChangeContent = Notification.Name("SettingsContentProvider.didChangeContent")
    static let sectionIndexSetKey = "SettingsContentProvider.sectionIndexSetKey"

    // MARK: Boilerplate

    private var sections: [SettingsContentSection] {
        var sections = [SettingsContentSection]()

        sections.append(contentsOf: ([
            AboutSection(),
            SettingsSection(),
            OtherAppsSection(otherApps: otherAppEntries),
            SocialSection()
        ] as [SettingsContentSection]))

        return sections.filter { $0.items.count > 0 }
    }
}
