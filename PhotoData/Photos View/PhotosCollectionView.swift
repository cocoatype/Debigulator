//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PhotosCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: PhotosCollectionViewLayout())
        backgroundColor = .systemBackground
        
        register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
    }
    
    override func reloadData() {
        (dataSource as? PhotosCollectionViewDataSource)?.reloadData()
        super.reloadData()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
