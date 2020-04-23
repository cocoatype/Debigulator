//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
    }

    var image: UIImage? {
        get { return imageView.image }
        set(newImage) { imageView.image = newImage }
    }

    // MARK: Boilerplate

    private let imageView = PreviewImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
