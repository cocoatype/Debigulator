//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

public enum PhotoCompressor {
    public static func compressedData(from image: UIImage) -> Data {
        let imageRect = CGRect(size: image.size)
        let targetRect = CGRect(size: Self.targetSize)
        let scaledRect = imageRect.fitting(rect: targetRect).integral
        let drawRect = CGRect(size: scaledRect.size)

        return UIGraphicsImageRenderer(size: scaledRect.size).jpegData(withCompressionQuality: 0.8) { context in
            image.draw(in: drawRect)
        }
    }

    // MARK: Boilerplate

    private static let targetSize = CGSize(width: 320, height: 320)
}
