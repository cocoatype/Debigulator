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

            let options = PHImageRequestOptions()
            options.deliveryMode = .opportunistic
            options.isNetworkAccessAllowed = true

            assetRequestID = imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { [weak self] image, info in
                guard let image,
                  let requestID = (info?[PHImageResultRequestIDKey] as? NSNumber)?.int32Value,
                  self?.assetRequestID == requestID
                else { return }

                self?.loadingIndicator.stopAnimating()
                self?.imageView.image = image
            }

            loadingIndicator.startAnimating()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(imageView)
        contentView.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
    private let imageView = PhotosCollectionViewCellImageView()
    private let loadingIndicator = PhotosCollectionViewCellLoadingIndicator()

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
