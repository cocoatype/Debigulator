//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos

class LibraryDataSource: NSObject {
    func reloadData() {
        allPhotos = self.fetchAllPhotos()
    }

    // MARK: Photos

    private lazy var allPhotos: PHFetchResult<PHAsset> = self.fetchAllPhotos()

    static func photo(withIdentifier identifier: String) -> PHAsset? {
        return PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil).firstObject
    }

    func photo(at index: Int) -> PHAsset { allPhotos[index] }
    var photosCount: Int { allPhotos.count }

    private func fetchAllPhotos() -> PHFetchResult<PHAsset> {
        guard PHPhotoLibrary.authorizationStatus() == .authorized else { return PHFetchResult() }

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return PHAsset.fetchAssets(with: fetchOptions)
    }
}
