//  Created by Geoff Pado on 4/20/20.
//  Copyright © 2020 Cocoatype. All rights reserved.

import Messages
import PhotoData

class MessagesViewController: MSMessagesAppViewController, PhotosViewControllerDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        let photosViewController = PhotosViewController()
        photosViewController.delegate = self
        embed(photosViewController)
    }
    
    // MARK: Photos View Controller Delegate
    
    func didFetchImageData(_ imageData: Data, highQualityImage: UIImage) {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            do {
                // we should do this asynchronously
                try imageData.write(to: temporaryFileURL)
                self?.activeConversation?.insertAttachment(temporaryFileURL, withAlternateFilename: nil, completionHandler: { error in
                    dump(error)
                })
            } catch { dump(error) }
        }
    }

    // MARK: Boilerplate
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }
}
