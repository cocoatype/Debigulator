//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PhotosCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: PhotosCollectionViewLayout())
        backgroundColor = .systemBlue
        
        register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
