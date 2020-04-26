//  Created by Geoff Pado on 4/25/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

class TutorialIntroScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
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
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentLayoutGuide.bottomAnchor),
            bodyLabel.centerYAnchor.constraint(equalTo: frameLayoutGuide.centerYAnchor),
        ])
    }

    private let headerLabel = TutorialIntroHeaderLabel(text: NSLocalizedString("TutorialIntroView.headerText", comment: "Text for the header of the tutorial intro"))
    private let bodyLabel = TutorialIntroBodyLabel(text: NSLocalizedString("TutorialIntroView.bodyText", comment: "Text for the body of the tutorial intro"))

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
