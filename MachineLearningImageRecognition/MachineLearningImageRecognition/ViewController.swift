//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Ali Mert Kaya on 2.08.2023.
//

import UIKit
import PhotosUI
import CoreML
import Vision

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var chosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func changeClicked(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = imageView.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.imageView.image == previousImage else { return }
                    self.imageView.image = image
                }
            }
        }
        
        // Model bir CIImage görsel yapısı bekler
        if let ciImage = CIImage(image: imageView.image!) {
            chosenImage = ciImage
        }
        recognizeImage(image: chosenImage)
    }
    
    func recognizeImage(image: CIImage) {
        
    }
}

