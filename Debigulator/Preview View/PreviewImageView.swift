//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
