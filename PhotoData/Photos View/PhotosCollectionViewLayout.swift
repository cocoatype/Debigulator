//  Created by Geoff Pado on 3/29/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PhotosCollectionViewLayout: UICollectionViewCompositionalLayout {
    init(void: Void = ()) {
        super.init { PhotosCollectionViewLayoutSection(environment: $1) }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}

class PhotosCollectionViewLayoutSection: NSCollectionLayoutSection {
    convenience init(environment: NSCollectionLayoutEnvironment) {
        self.init(group: PhotosCollectionViewLayoutGroup.standard(environment: environment))
    }
}

class PhotosCollectionViewLayoutGroup: NSCollectionLayoutGroup {
    class func standard(environment: NSCollectionLayoutEnvironment) -> Self {
        let environmentWidth = environment.container.effectiveContentSize.width
        let itemsPerGroup = floor(environmentWidth / Self.targetWidth)
        let actualItemWidth = environmentWidth / itemsPerGroup

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(actualItemWidth))

        return Self.horizontal(layoutSize: groupSize, subitems: [PhotosCollectionViewLayoutItem(itemWidth: actualItemWidth)])
    }

    private static let targetWidth = CGFloat(80)
}

class PhotosCollectionViewLayoutItem: NSCollectionLayoutItem {
    convenience init(itemWidth: CGFloat) {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(itemWidth))
        self.init(layoutSize: layoutSize)
    }
}
