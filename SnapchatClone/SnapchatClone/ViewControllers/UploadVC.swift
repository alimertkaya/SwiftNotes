//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Ali Mert Kaya on 9.08.2023.
//

import UIKit
import PhotosUI

class UploadVC: UIViewController, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate{

    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(chosenImage))
        uploadImageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func chosenImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = uploadImageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.uploadImageView.image == previousImage else { return }
                    self.uploadImageView.image = image
                }
            }
        }
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
    }
}
