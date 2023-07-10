//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ali Mert Kaya on 10.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var xauLabel: UILabel!
    @IBOutlet weak var btcLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        // 1) Request & Session
        // url oluşturma
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9ec1823c3c3b7979f76eddcb73a9c17e")
        
        // istek yapıcaz (session), veri-alışveri için
        // .shared URLSession object i oluşturur, hep aynı object üzerinden gider birçok veri varken karışıklıklığı önler
        let session = URLSession.shared
        
        // fonksiyonu çağırırken çıktı beklenir, bu çıktığı closure içerisinde verir
        let task = session.dataTask(with: url!) { data, response, error in
            // hata varsa kullanıcıya göster
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                // 2) Response & Data
                if data != nil {
                    
                    // JSON result object oluşturucaz, veriyi JSON olarak alıyoruz işlemek için
                    do {
                        // mutableContainers -> dictionaries rı JSON objectimiz ile kullanmamızı sağlar
                        let jsonRenponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        // Arka planda bu işlemler yapılırken arayüz kitlenmesin, uygulama çökmesin diye
                        DispatchQueue.main.async {
                            print(jsonRenponse)
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        // task i başlatır
        task.resume()
    }
}
