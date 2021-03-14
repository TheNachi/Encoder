//
//  Helper.swift
//  Encoder
//
//  Created by Munachimso Ugorji on 13/03/2021.
//

import AVKit
import MobileCoreServices

enum VideoHelper {
  static func startMediaBrowser(
    delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
    sourceType: UIImagePickerController.SourceType
  ) {
    guard UIImagePickerController.isSourceTypeAvailable(sourceType)
      else { return }

    let mediaUI = UIImagePickerController()
    mediaUI.sourceType = sourceType
    mediaUI.mediaTypes = [kUTTypeMovie as String]
    mediaUI.allowsEditing = true
    mediaUI.delegate = delegate
    delegate.present(mediaUI, animated: true, completion: nil)
  }
}


struct CustomError: Error, LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }

    let message: String

}
