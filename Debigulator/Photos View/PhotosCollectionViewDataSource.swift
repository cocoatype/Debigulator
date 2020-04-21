//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

class PhotosCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func asset(at indexPath: IndexPath) -> PHAsset { libraryDataSource.photo(at: indexPath.item) }
    
    // MARK: Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return libraryDataSource.photosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath)
        guard let photoCell = (cell as? PhotosCollectionViewCell) else {
            assertionFailure("Cell was not a photo cell: \(cell)")
            return cell
        }
        
        photoCell.asset = asset(at: indexPath)
        return photoCell
    }
    
    // MARK: Boilerplate
    
    private let libraryDataSource = LibraryDataSource()
}
