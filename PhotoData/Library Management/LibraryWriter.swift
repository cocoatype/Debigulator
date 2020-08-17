//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Photos
import UIKit

public enum LibraryWriter {
    public static func write(_ data: Data, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        queue.addOperation {
            do {
                let temporaryURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
                try data.write(to: temporaryURL)

                let library = PHPhotoLibrary.shared()
                try library.performChangesAndWait {
                     PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: temporaryURL)
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }

    public static func write(_ image: UIImage, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        queue.addOperation {
            do {
                let library = PHPhotoLibrary.shared()
                try library.performChangesAndWait {
                     PHAssetChangeRequest.creationRequestForAsset(from: image)
                }
                completionHandler(.success(()))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }

    private static let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()
}
