//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroHeaderLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)

        let lines = text.split(separator: "\n")
        let firstLine = NSAttributedString(string: String(lines[0]), attributes: [.foregroundColor: UIColor.label])
        let secondLine = NSAttributedString(string: String(lines[1]), attributes: [.foregroundColor: UIColor.appAccent])

        let tintedString = NSMutableAttributedString(attributedString: firstLine)
        tintedString.append(NSAttributedString(string: "\n"))
        tintedString.append(secondLine)
        self.attributedText = tintedString

        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        allowsDefaultTighteningForTruncation = true
        font = .appFont(forTextStyle: .largeTitle)
        minimumScaleFactor = 0.5
        numberOfLines = 2
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
