//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        addSubview(buttonsView)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            scrollView.bottomAnchor.constraint(equalTo: buttonsView.topAnchor, constant: -22),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            buttonsView.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: Boilerplate
    private let buttonsView = TutorialIntroButtonsStackView()
    private let scrollView = TutorialIntroScrollView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
