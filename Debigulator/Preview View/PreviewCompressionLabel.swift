//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewCompressionLabel: UILabel {
    init(for compression: Compression) {
        super.init(frame: .zero)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        updateText(for: compression)
    }

    private func updateText(for compression: Compression) {
        switch compression {
        case .notCompressed:
            text = Self.notCompressedText
        case .compressed:
            let factor = Int(compression.factor)
            text = String(format: Self.compressedText, factor)
        }
    }

    // MARK: Boilerplate

    private static let compressedText = NSLocalizedString("PreviewCompressionLabel.compressedText", comment: "")
    private static let notCompressedText = NSLocalizedString("PreviewCompressionLabel.notCompressedText", comment: "")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
