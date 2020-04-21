//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Messages
import PhotoData

class MessagesViewController: MSMessagesAppViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        embed(PhotosViewController())
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
