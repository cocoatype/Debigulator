//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroStartButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGreen
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        setTitleColor(.label, for: .normal)
        setTitle(Self.title, for: .normal)
        layer.cornerRadius = 8

        addTarget(nil, action: #selector(SceneViewController.requestPhotoPermissions(_:)), for: .primaryActionTriggered)
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroStartButton.title", comment: "Title for the button to start the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
