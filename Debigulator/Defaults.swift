//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Foundation

enum Defaults {
    public static func initialize() {
        userDefaults.register(defaults: [
            Self.seenIntroKey: false
        ])
    }

    private static let userDefaults: UserDefaults = {
        guard let defaults = UserDefaults(suiteName: "group.com.cocoatype.Debigulator") else { fatalError("Unable to create user defaults") }
        return defaults
    }()

    // MARK: Values

    public static var seenIntro: Bool {
        get { return userDefaults.bool(forKey: Self.seenIntroKey) }
        set(newSeenIntro) {
            userDefaults.set(newSeenIntro, forKey: Self.seenIntroKey)
        }
    }

    // MARK: Keys

    private static let seenIntroKey = "Defaults.seenTutorialKey"
}
