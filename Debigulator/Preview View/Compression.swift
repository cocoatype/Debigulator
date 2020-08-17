//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Foundation

enum Compression {
    case notCompressed
    case compressed(compressed: Int, original: Int)

    init(compressedData: Data, originalData: Data) {
        let compressed = compressedData.count
        let original = originalData.count
        if compressed < original {
            self = .compressed(compressed: compressed, original: original)
        } else {
            self = .notCompressed
        }
    }

    var result: Double {
        switch self {
        case .notCompressed: return 0
        case .compressed(let compressed, let original):
            return Double(compressed) / Double(original)
        }
    }

    var removed: Double { 1 - result }

    var factor: Double {
        switch self {
        case .notCompressed: return 0
        case .compressed(let compressed, let original):
            return Double(original - compressed) / Double(compressed)
        }
    }
}
