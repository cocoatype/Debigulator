//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PhotosCollectionViewLayout: UICollectionViewCompositionalLayout {
    init(void: Void = ()) {
        super.init(section: PhotosCollectionViewLayoutSection())
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

class PhotosCollectionViewLayoutSection: NSCollectionLayoutSection {
    convenience init(void: Void = ()) {
        self.init(group: PhotosCollectionViewLayoutGroup.standard())
    }
}

class PhotosCollectionViewLayoutGroup: NSCollectionLayoutGroup {
    class func standard() -> Self {
        return Self.horizontal(layoutSize: groupSize, subitems: [PhotosCollectionViewLayoutItem()])
    }
    
    private static let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
}

class PhotosCollectionViewLayoutSize: NSCollectionLayoutSize {
    convenience init(void: Void = ()) {
        self.init(widthDimension: .absolute(80), heightDimension: .absolute(80))
    }
}

class PhotosCollectionViewLayoutItem: NSCollectionLayoutItem {
    convenience init(void: Void = ()) {
        self.init(layoutSize: PhotosCollectionViewLayoutSize())
    }
}
