//  Created by Geoff Pado on 8/16/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import UIKit

enum PreviewSaveAlertFactory {
    static func alert(for result: Result<Void, Error>) -> UIAlertController {
        switch result {
        case .success: return successAlert
        case .failure: return failureAlert
        }
    }

    // MARK: Success

    private static let successTitle = NSLocalizedString("PreviewSaveAlertFactory.successTitle", comment: "Title for the save success alert")
    private static let successMessage = NSLocalizedString("PreviewSaveAlertFactory.successMessage", comment: "Message for the save success alert")
    private static var successAlert: UIAlertController {
        let alert = UIAlertController(title: successTitle, message: successMessage, preferredStyle: .alert)
        alert.view.tintColor = .appAccent
        alert.addAction(dismissAction)
        return alert
    }

    // MARK: Failure

    private static let failureTitle = NSLocalizedString("PreviewSaveAlertFactory.failureTitle", comment: "Title for the save failure alert")
    private static let failureMessage = NSLocalizedString("PreviewSaveAlertFactory.failureMessage", comment: "Message for the save failure alert")
    private static var failureAlert: UIAlertController {
        let alert = UIAlertController(title: failureTitle, message: failureMessage, preferredStyle: .alert)
        alert.view.tintColor = .appAccent
        alert.addAction(dismissAction)
        return alert
    }

    // MARK: Dismissal

    private static let dismissButtonTitle = NSLocalizedString("PreviewSaveAlertFactory.dismissButtonTitle", comment: "Dismiss button for save alerts")
    private static let dismissAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
}
