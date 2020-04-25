//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import UIKit

class SceneViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
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
        let introViewController = TutorialIntroViewController()
        introViewController.presentationController?.delegate = self
        present(introViewController, animated: false, completion: nil)
    }

    @objc func requestPhotoPermissions(_ sender: Any) {
        dismiss(animated: true) { [weak self] in
            self?.photoViewController?.requestPhotoPermissions()
        }
    }

    @objc func showHelp() {
        guard presentedViewController == nil else { return }
        let settingsNavigationController = SettingsNavigationController()
        present(settingsNavigationController, animated: true, completion: nil)
    }

    @objc func dismissHelp() {
        guard (presentedViewController is SettingsNavigationController) else { return }
        dismiss(animated: true)
    }

    // MARK: Presentation Controller Delegate

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        photoViewController?.requestPhotoPermissions()
    }

    // MARK: Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }

    // MARK: Boilerplate

    private var sceneNavigationController: NavigationController? { children.first as? NavigationController }
    private var photoViewController: PhotosViewController? { navigationController?.topViewController as? PhotosViewController }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

class MainAppPhotosViewController: PhotosViewController {
    override init() {
        super.init()

        navigationItem.title = Self.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle"), style: .plain, target: nil, action: #selector(SceneViewController.showHelp))
    }

    private static let navigationTitle = NSLocalizedString("PhotosViewController.navigationTitle", comment: "Title when displayed in a navigation controller")
}
