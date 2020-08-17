//  Created by Geoff Pado on 4/22/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class PreviewView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        addSubview(imageView)

        addGestureRecognizer(focusRecognizer)
        addGestureRecognizer(qualityRecognizer)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    var isFocusing = false {
        didSet {
            backgroundColor = (isFocusing ? .black : .systemBackground)
        }
    }

    var image: UIImage? {
        get { return imageView.image }
        set(newImage) { imageView.image = newImage }
    }

    // MARK: Focus

    @objc func toggleFocus() { next?.perform(#selector(PreviewViewController.toggleFocus)) }
    private lazy var focusRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFocus))

    // MARK: Quality

    private lazy var qualityRecognizer: UIGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(toggleQuality))
        recognizer.minimumPressDuration = 0.1
        recognizer.allowableMovement = .greatestFiniteMagnitude
        return recognizer
    }()

    @objc func toggleQuality(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            next?.perform(#selector(PreviewViewController.showHighQuality))
        case .cancelled, .ended, .failed:
            next?.perform(#selector(PreviewViewController.showLowQuality))
        case .changed, .possible: fallthrough
        @unknown default: break
        }
    }

    // MARK: Actions

    func install(_ actionsViewController: PreviewActionsViewController) {
        guard let view = actionsViewController.view else {
            fatalError("Actions view controller installed before loading view")
        }

        addSubview(view)

        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    // MARK: Boilerplate

    private let imageView = PreviewImageView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
