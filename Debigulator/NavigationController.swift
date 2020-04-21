//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import UIKit

class NavigationController: UINavigationController {
    init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
        setViewControllers([PhotosViewController()], animated: false)
        navigationBar.standardAppearance = NavigationBarAppearance()
    }

    // MARK: Boilerplate

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
