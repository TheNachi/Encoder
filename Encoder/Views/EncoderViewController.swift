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
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
              mediaType == (kUTTypeMovie as String),
              let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
            return
        }
        
        
        dismiss(animated: false) {
            guard let encodingVC = self.storyboard?.instantiateViewController(withIdentifier: "encodingVC") as? EncodingViewController else { return }
            let encodingVM = EncodingViewModel(with: videoUrl)
            encodingVC.viewModel = encodingVM
            self.present(encodingVC, animated: false, completion: nil)
            
        }
    }
    
}

extension EncoderViewController: UINavigationControllerDelegate {
}

