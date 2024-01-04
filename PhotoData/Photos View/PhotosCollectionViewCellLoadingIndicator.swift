//  Created by Geoff Pado on 1/4/24.
//  Copyright © 2024 Cocoatype. All rights reserved.

import UIKit

class PhotosCollectionViewCellLoadingIndicator: UIActivityIndicatorView {
    init() {
        super.init(style: .large)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
