//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewViewController: UIViewController {
    init(imageData: Data) {
        image = UIImage(data: imageData)

        super.init(nibName: nil, bundle: nil)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareImage))
    }

    override func loadView() {
        previewView.image = image
        view = previewView
    }

    @objc private func shareImage() {
        guard let image = image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    // MARK: Boilerplate

    private let image: UIImage?
    private let previewView = PreviewView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
