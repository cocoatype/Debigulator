//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewShareActionButton: ActionButton {
    override init() {
        super.init()
        setTitle(Self.title, for: .normal)
        addTarget(nil, action: #selector(PreviewViewController.shareImage), for: .primaryActionTriggered)
    }

    private static let title = NSLocalizedString("PreviewShareActionButton.title", comment: "Title for the share button in the preview view")
}
