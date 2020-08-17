//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewActionsView: UIVisualEffectView {
    init(compression: Compression) {
        compressionLabel = PreviewCompressionLabel(for: compression)
        super.init(effect: UIBlurEffect(style: .systemThickMaterial))
        translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(compressionLabel)
        contentView.addSubview(saveButton)
        contentView.addSubview(shareButton)

        NSLayoutConstraint.activate([
            compressionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            compressionLabel.trailingAnchor.constraint(equalTo: saveButton.trailingAnchor),
            compressionLabel.leadingAnchor.constraint(equalTo: saveButton.leadingAnchor),
            saveButton.topAnchor.constraint(equalTo: compressionLabel.bottomAnchor, constant: 11),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor),
            saveButton.leadingAnchor.constraint(equalTo: shareButton.leadingAnchor),
            shareButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 11),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            shareButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            shareButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22)
        ])
    }

    // MARK: Boilerplate

    private let compressionLabel: PreviewCompressionLabel
    private let saveButton = PreviewSaveActionButton()
    private let shareButton = PreviewShareActionButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
