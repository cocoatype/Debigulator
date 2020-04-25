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
//            buttonsView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.bottomAnchor, constant: 22),
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

class TutorialIntroScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
//        contentInset = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(headerLabel)
        addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor, constant: 22),
            headerLabel.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: -22),
            headerLabel.topAnchor.constraint(greaterThanOrEqualTo: contentLayoutGuide.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 11),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentLayoutGuide.bottomAnchor)
//            bodyLabel.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
        ])
    }

    private let headerLabel = TutorialIntroHeaderLabel(text: NSLocalizedString("TutorialIntroView.headerText", comment: "Text for the header of the tutorial intro"))
    private let bodyLabel = TutorialIntroBodyLabel(text: NSLocalizedString("TutorialIntroView.bodyText", comment: "Text for the body of the tutorial intro"))

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
