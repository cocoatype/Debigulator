//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroBodyLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        adjustsFontForContentSizeCategory = true
        font = .appFont(forTextStyle: .callout)
        numberOfLines = 0
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }

    private func correctlyPronounced(_ string: String) -> NSAttributedString {
        let range = (string as NSString).range(of: "Kineo")
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.accessibilitySpeechIPANotation, value: "ˈkɪ.ni.o͡ʊ", range: range)
        return attributedString
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
