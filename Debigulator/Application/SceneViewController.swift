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
        present(introViewController, animated: true, completion: nil)
    }

    @objc func requestPhotoPermissions() {
        photoViewController?.requestPhotoPermissions() { [weak self] status in
            switch status {
            case .authorized:
                self?.dismiss(animated: true)
            case .restricted:
                self?.presentedViewController?.present(PhotoPermissionsRestrictedAlertFactory.alert, animated: true)
            case .denied:
                self?.presentedViewController?.present(PhotoPermissionsDeniedAlertFactory.alert, animated: true)
            case .notDetermined:
                fallthrough
            @unknown default:
                break
            }
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

    // MARK: External Photo Loading

    func openPhoto(at url: URL) {
        do {
            let originalData = try Data(contentsOf: url)
            guard let image = UIImage(data: originalData) else { return }
            let compressedData = PhotoCompressor.compressedData(from: image)
            sceneNavigationController?.didFetchImageData(compressedData, originalData: originalData)
        } catch {}
    }

    // MARK: Presentation Controller Delegate

    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        requestPhotoPermissions()
    }

    // MARK: Status Bar

    override var childForStatusBarHidden: UIViewController? {
        return sceneNavigationController?.topViewController
    }

    // MARK: Boilerplate

    private var sceneNavigationController: NavigationController? { children.first as? NavigationController }
    private var photoViewController: PhotosViewController? { sceneNavigationController?.topViewController as? MainAppPhotosViewController }

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
