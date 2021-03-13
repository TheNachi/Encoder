//
//  ViewController.swift
//  Encoder
//
//  Created by Munachimso Ugorji on 13/03/2021.
//

import UIKit
import MobileCoreServices

class EncoderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleOpenPhotos(_ sender: UIButton) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
}

extension EncoderViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // 1
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
              mediaType == (kUTTypeMovie as String),
              let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
            return
        }
        
        
        // 2
        dismiss(animated: false) {
//            guard let secondVC = self.storyboard?.instantiateViewController(identifier: "secondVC") as? SecondViewController else { return }
//            let secondVM = SecondViewModel(with: videoUrl)
//            secondVC.viewModel = secondVM
//            self.present(secondVC, animated: false, completion: nil)
            
        }
    }
    
}

extension EncoderViewController: UINavigationControllerDelegate {
}

