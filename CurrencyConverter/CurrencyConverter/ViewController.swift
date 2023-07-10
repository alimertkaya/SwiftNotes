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
                        // dictionary olarak cast ediyoruz istediğimiz verilere kolay ulaşmak için (key-value)
                        let jsonRenponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // Arka planda bu işlemler yapılırken arayüz kitlenmesin, uygulama çökmesin diye
                        DispatchQueue.main.async {
                            // 3) Parsing & JSON Serialization
                            // rates dictionary sine ulaşmak ve cast etmek için
                            if let rates = jsonRenponse["rates"] as? [String: Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                
                                if let xau = rates["XAU"] as? Double {
                                    self.xauLabel.text = "XAU: \(xau)"
                                }
                                
                                if let bitcoin = rates["BTC"] as? Double {
                                    self.btcLabel.text = "BTC: \(bitcoin)"
                                }
                            }
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
