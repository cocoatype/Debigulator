//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

open class PhotosViewController: UIViewController, UICollectionViewDelegate {
    public weak var delegate: PhotosViewControllerDelegate?

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func loadView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        view = collectionView
    }

    public func requestPhotoPermissions(_ completionHandler: ((PHAuthorizationStatus) -> Void)? = nil) {
        requester.requestAuthorization { [weak self] status in
            self?.collectionView.reloadData()
            completionHandler?(status)
        }
    }
    
    // MARK: Collection View Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = dataSource.asset(at: indexPath)
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        imageManager.requestImage(for: asset, targetSize: Self.targetSize, contentMode: .aspectFill, options: options) { [weak self] image, _ in
            guard let imageData = image?.jpegData(compressionQuality: 0.8) else { return }
            self?.delegate?.didFetchImageData(imageData)
        }
    }
    
    // MARK: Boilerplate

    private static let targetSize = CGSize(width: 320, height: 320)
    
    private let collectionView = PhotosCollectionView()
    private let dataSource = PhotosCollectionViewDataSource()
    private let imageManager = PHImageManager()
    private let requester = LibraryPermissionsRequester()

    @available(*, unavailable)
    public required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
