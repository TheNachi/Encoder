//
//  EncodingViewController.swift
//  Encoder
//
//  Created by Munachimso Ugorji on 13/03/2021.
//

import UIKit

class EncodingViewController: UIViewController {
    
    var viewModel: EncodingViewModel?
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.delegate = self
        self.bindViewModel(with: viewModel)
    }
    
    func bindViewModel(with viewModel: EncodingViewModel?) {
        viewModel?.encodeVideo2()
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved successfully in your photos, go back to encode more videos" : "Video failed to save"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.cancel,
                            handler: goBackToEncoderVC))
        present(alert, animated: true, completion: nil)
    }
    
    func goBackToEncoderVC(action: UIAlertAction) {
        guard let encoderVC = self.storyboard?.instantiateViewController(withIdentifier: "EncoderVC") as? EncoderViewController else { return }
        self.present(encoderVC, animated: true, completion: nil)
    }
}

extension EncodingViewController: EncodingDelegate {
    func handleFail(_ error: Error) {
        
    }
    
    
    func saveVideo(with url: URL) {
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
            UISaveVideoAtPathToSavedPhotosAlbum(
                url.path,
                self,
                #selector(self.video(_:didFinishSavingWithError:contextInfo:)),
                nil)
        }
    }
    
    func trackProgress(with progress: Float) {
        DispatchQueue.main.async {
            self.progressView.progress = 0.0
            self.progressView.progress = progress
        }
    }
}
