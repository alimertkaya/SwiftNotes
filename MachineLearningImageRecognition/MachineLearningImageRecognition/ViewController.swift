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
                    
                    // Model bir CIImage görsel yapısı bekler
                    if let ciImage = CIImage(image: image) {
                        self.chosenImage = ciImage
                    }
                }
            }
        }
        
        recognizeImage(image: chosenImage)
    }
    
    func recognizeImage(image: CIImage) {
        // 1) Request
        // 2) Handler
        
        resultLabel.text = "Finding..."
        
        // MobilNewV2 modelini bir değişkene atıyoruz
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            let request = VNCoreMLRequest(model: model) { vnrequest, error in
                
                // VNClassificationObservation -> görsel analizinin sonucunda üretilen sınıflandırılma
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    // ilk sonucu almak en yüksek olasılıklı sonucu verir
                    if results.count > 0 {
                        let topResult = results.first
                        
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0) * 100
                            let rounded = (Int(confidenceLevel) * 100) / 100
                            self.resultLabel.text = "\(rounded)% it's \(topResult?.identifier)"
                        }
                    }
                }
            }
            let handler = VNImageRequestHandler(ciImage: image)
            // DispatchQueue.global() -> çok önerilmez işleme öncelik vererek çok hızlı yapmasını söyler
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                    } catch {
                        print("error")
                }
            }
        }
    }
}
