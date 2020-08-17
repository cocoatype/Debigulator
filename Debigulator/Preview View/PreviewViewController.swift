//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import PhotoData
import UIKit

class PreviewViewController: UIViewController {
    init(imageData: Data, originalData: Data) {
        guard let lowQualityImage = UIImage(data: imageData),
              let highQualityImage = UIImage(data: originalData)
        else {
            fatalError("Invalid image data")
        }

        self.lowQualityImage = lowQualityImage
        self.highQualityImage = highQualityImage

        compression = Compression(compressedData: imageData, originalData: originalData)
        previewActionsViewController =  PreviewActionsViewController(compression: compression)
        super.init(nibName: nil, bundle: nil)

        addChild(previewActionsViewController)

        edgesForExtendedLayout = .top
        navigationItem.largeTitleDisplayMode = .never
    }

    override func loadView() {
        previewView.image = lowQualityImage
        previewView.install(previewActionsViewController)
        view = previewView
    }

    @objc func saveImage() {
        LibraryWriter.write(lowQualityImage) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                let alert = PreviewSaveAlertFactory.alert(for: result)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc func shareImage() {
        let activityViewController = UIActivityViewController(activityItems: [lowQualityImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    // MARK: Actions

    @objc func toggleFocus() {
        let duration = TimeInterval(UINavigationController.hideShowBarDuration)
        UIView.animate(withDuration: duration) { [unowned self] in
            self.isFocusing.toggle()
        }
    }

    private var isFocusing = false {
        didSet {
            previewView.isFocusing = isFocusing
            navigationController?.setNavigationBarHidden(isFocusing, animated: true)
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    @objc func showLowQuality() {
        previewView.image = lowQualityImage
    }

    @objc func showHighQuality() {
        previewView.image = highQualityImage
    }

    // MARK: Status Bar

    override var prefersStatusBarHidden: Bool { isFocusing }

    // MARK: Boilerplate

    private let compression: Compression
    private let lowQualityImage: UIImage
    private let highQualityImage: UIImage
    private let previewView = PreviewView()
    private let previewActionsViewController: PreviewActionsViewController

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
