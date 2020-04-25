//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import UIKit

class NavigationController: UINavigationController, PhotosViewControllerDelegate {
    init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
        photosViewController.delegate = self

        setViewControllers([photosViewController], animated: false)
        navigationBar.standardAppearance = NavigationBarAppearance()
        navigationBar.scrollEdgeAppearance = NavigationBarAppearance()
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .barTint
    }

    func didFetchImageData(_ imageData: Data) {
        pushViewController(PreviewViewController(imageData: imageData), animated: true)
    }

    // MARK: Boilerplate

    private let photosViewController = MainAppPhotosViewController()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
