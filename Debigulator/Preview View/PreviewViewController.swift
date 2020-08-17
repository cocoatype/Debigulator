//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewViewController: UIViewController {
    init(imageData: Data, originalData: Data) {
        lowQualityImage = UIImage(data: imageData)
        highQualityImage = UIImage(data: originalData)
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

    }

    @objc func shareImage() {
        guard let image = lowQualityImage else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
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
    private let lowQualityImage: UIImage?
    private let highQualityImage: UIImage?
    private let previewView = PreviewView()
    private let previewActionsViewController: PreviewActionsViewController

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
