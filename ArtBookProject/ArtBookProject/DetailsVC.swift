//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Ali Mert Kaya on 18.04.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var chosenPainting = ""
    var chosenPaintingId : UUID?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Seçilen resim boş değil ise
        if chosenPainting != "" {
            
            // save butonu gizler
            saveButton.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString

            // Yazılan koşulu bulup getirecek
            // id si idString olan şeyi getir demek
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
        else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
        
        // Recognizers
        
        // klavyenin kapanması için
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // kullanıcı görsele tıklayabilir mi
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage() {
        
        // resim,video vs için kullanıcının medya kütüphanesine erişmeyi sağlar
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        // kullanıcı görseli düzenleyebilir
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    // resmi seçtikten sonra ne olucak
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
         
        // AppDelegate de context de ulaşmak için AppDelegate i bir değişken gibi tanımlarız
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // entity ismi ve kaydedileceği yer
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        // Attributes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        newPainting.setValue(UUID(), forKey: "id")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        // image i data ya çeviriyoruz boyutunun yarısını alırak
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            // veritabanı kaydet
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        // VC ler arası mesaj yollamayı sağlar, iletişim kurar
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        // Bir önceki VC a geri gitmeyi sağlar
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}
