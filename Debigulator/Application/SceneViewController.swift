//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import PhotosUI
import UIKit

class SceneViewController: UIViewController, UIAdaptivePresentationControllerDelegate, PHPickerViewControllerDelegate {
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
            self?.dismiss(animated: true)
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

    // MARK: Photo Picker

    @available(iOS 14.0, *)
    @objc func showPhotoPicker() {
        let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        let picker = PHPickerViewController(configuration: configuration)
        picker.view.tintColor = .appAccent
        picker.delegate = self
        present(picker, animated: true)
    }

    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        guard let result = results.first else { return }

        let itemProvider = result.itemProvider
        guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first else { return }

        itemProvider.loadDataRepresentation(forTypeIdentifier: typeIdentifier) { [weak self] data, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            let compressedData = PhotoCompressor.compressedData(from: image)

            DispatchQueue.main.async { [weak self] in
                self?.sceneNavigationController?.didFetchImageData(compressedData, originalData: data)
            }
        }
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

        if #available(iOS 14.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(SceneViewController.showPhotoPicker))
        }
    }

    private static let navigationTitle = NSLocalizedString("PhotosViewController.navigationTitle", comment: "Title when displayed in a navigation controller")
}
