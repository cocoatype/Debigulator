//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

public protocol PhotosViewControllerDelegate: class {
    func didFetchImageData(_ imageData: Data, highQualityImage: UIImage)
}
