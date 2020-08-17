//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewActionsViewController: UIViewController {
    init(compression: Compression) {
        actionsView = PreviewActionsView(compression: compression)
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        view = actionsView
    }

    // MARK: Boilerplate

    private let actionsView: PreviewActionsView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
