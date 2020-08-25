//  Created by Geoff Pado on 8/21/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import CoreServices
import Intents
import PhotoData
import UIKit

class IntentHandler: INExtension, DebigulateImageIntentHandling {
    func handle(intent: DebigulateImageIntent, completion: @escaping (DebigulateImageIntentResponse) -> Void) {
        guard let data = intent.sourceImage?.data, let image = UIImage(data: data) else {
            return completion(.failure)
        }

        let compressedData = PhotoCompressor.compressedData(from: image)
        completion(.success(compressedData))
    }

    override func handler(for intent: INIntent) -> Any {
        return self
    }
}

extension DebigulateImageIntentResponse {
    static func success(_ compressedImageData: Data) -> DebigulateImageIntentResponse {
        let response = DebigulateImageIntentResponse(code: .success, userActivity: nil)
        response.compressedImage = INFile(data: compressedImageData, filename: "\(UUID().uuidString).jpg", typeIdentifier: (kUTTypeJPEG as String))
        return response
    }
    static var failure = DebigulateImageIntentResponse(code: .failure, userActivity: nil)
}
