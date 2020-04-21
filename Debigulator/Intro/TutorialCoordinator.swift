//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Foundation

class TutorialCoordinator: NSObject {
    static var shouldStartTutorial: Bool {
        return forceShowTutorial || Defaults.seenIntro == false
    }

    // MARK: Override

    private static let forceShowTutorialEnvironmentVariable = "FORCE_SHOW_TUTORIAL"
    private static var forceShowTutorial: Bool {
        ProcessInfo.processInfo.environment[forceShowTutorialEnvironmentVariable] != nil
    }
}
