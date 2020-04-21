//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import UIKit

class SceneViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        embed(NavigationController())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if TutorialCoordinator.shouldStartTutorial {
            showIntro()
        }
    }

    private func showIntro() {
        guard presentedViewController == nil else { return }
        present(TutorialIntroViewController(), animated: true, completion: nil)
    }

    @objc func requestPhotoPermissions(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.photoViewController?.requestPhotoPermissions()
        }
    }

    // MARK: Boilerplate

    private var photoViewController: PhotosViewController? {
        let navigationController = children.first as? NavigationController
        return navigationController?.topViewController as? PhotosViewController
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
