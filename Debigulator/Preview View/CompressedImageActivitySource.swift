//  Created by Geoff Pado on 8/21/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import CoreServices
import LinkPresentation
import UIKit

class CompressedImageActivitySource: NSObject, UIActivityItemSource {
    init(data: Data) {
        self.data = data
    }

    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        return kUTTypeImage as String
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return data
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return data
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.imageProvider = ImageProvider(data)
        metadata.title = Self.title
        return metadata
    }

    private static let title = NSLocalizedString("PreviewViewController.title", comment: "Title shown when sharing an image")
    private let data: Data

    private class ImageProvider: NSItemProvider {
        init(_ data: Data) {
            super.init()

            registerObject(ofClass: UIImage.self, visibility: .all) { handler -> Progress? in
                let image = UIImage(data: data)
                handler(image, nil)
                return nil
            }
        }
    }
}
