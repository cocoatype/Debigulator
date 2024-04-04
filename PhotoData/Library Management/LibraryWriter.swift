//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

public enum LibraryWriter {
    public static func write(_ data: Data) async throws {
        let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try data.write(to: temporaryURL)

        let library = PHPhotoLibrary.shared()
        try await library.performChanges {
            PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: temporaryURL)
        }
    }

    public static func write(_ image: UIImage) async throws {
        let library = PHPhotoLibrary.shared()
        try await library.performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
    }
}
