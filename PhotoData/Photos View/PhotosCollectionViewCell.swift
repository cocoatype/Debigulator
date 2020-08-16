//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotosCollectionViewCell.identifier"

    var asset: PHAsset? {
        didSet {
            guard let asset = asset else {
                assetRequestID = nil
                imageView.image = nil
                return
            }

            let targetSize = bounds.size * UIScreen.main.scale

            assetRequestID = imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { [weak self] image, info in
                guard let image = image,
                  let requestID = (info?[PHImageResultRequestIDKey] as? NSNumber)?.int32Value,
                  self?.assetRequestID == requestID
                else { return }

                self?.imageView.image = image
            }
        }
    }

    override init(frame: CGRect) {
        imageView = PhotosCollectionViewCellImageView()

        super.init(frame: .zero)

        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        isAccessibilityElement = true
        backgroundColor = .secondarySystemBackground
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        asset = nil
    }

    // MARK: Boilerplate

    private let imageManager = PHImageManager.default()
    private var imageView: UIImageView

    private var assetRequestID: PHImageRequestID? {
        didSet {
            guard let oldValue = oldValue else { return }
            imageManager.cancelImageRequest(oldValue)
        }
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
