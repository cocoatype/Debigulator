//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    override func loadView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        view = collectionView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requester.requestAuthorization { status in
            print(status)
        }
    }
    
    // MARK: Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = dataSource.asset(at: indexPath)
        imageManager.requestImage(for: asset, targetSize: Self.targetSize, contentMode: .aspectFill, options: nil) { image, info in
            dump(image)
            let imageData = image?.jpegData(compressionQuality: 0.8)
            dump(imageData)
        }
    }
    
    // MARK: Boilerplate
    private static let targetSize = CGSize(width: 320, height: 320)
    
    private let collectionView = PhotosCollectionView()
    private let dataSource = PhotosCollectionViewDataSource()
    private let imageManager = PHImageManager()
    private let requester = LibraryPermissionsRequester()
}
