//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroStartButton: ActionButton {
    override init() {
        super.init()
        setTitle(Self.title, for: .normal)
        addTarget(nil, action: #selector(SceneViewController.requestPhotoPermissions), for: .primaryActionTriggered)
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroStartButton.title", comment: "Title for the button to start the tutorial")
}
