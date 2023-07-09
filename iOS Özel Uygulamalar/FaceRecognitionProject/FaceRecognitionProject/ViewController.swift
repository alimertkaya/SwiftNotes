//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Ali Mert Kaya on 9.07.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        // LAContext() doğrulama işlemleri için kullanılır
        let autContext = LAContext()
        
        var error: NSError?
        
        // parmak izi mi yüz tanıma mi seçilir, &error -> & pointer yapmayı sağlar
        if autContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            autContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                // başarılı olursa segue yapar
                if success == true {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
        }
    }
}

/*
 DispatchQueue.main.async bir Grand Central Dispatch (GCD) fonksiyonudur ve genellikle UI güncellemeleri gibi ana iş parçacığı üzerinde çalışması gereken işleri planlamak için kullanılır.

 iOS uygulamaları, ana iş parçacığı (main thread) olarak adlandırılan bir iş parçacığında çalışır. Ana iş parçacığı, kullanıcı arayüzünün oluşturulması ve güncellenmesi gibi görevleri gerçekleştirir. Ancak, bazı işlemler, ağ çağrıları, veritabanı erişimi veya yoğun hesaplamalar gibi, uzun sürebilir ve ana iş parçacığının bloke olmasına neden olabilir. Bu durumda, uygulama tepkisiz kalabilir ve kullanıcı arayüzü donabilir.

 DispatchQueue.main.async kullanarak, belirli bir bloğu veya işi ana iş parçacığı üzerinde asenkron olarak planlayabilirsiniz. Bu, uzun süren veya potansiyel olarak bloke edici işlemleri ana iş parçacığı üzerinde gerçekleştirmeden arka planda işleyebilir ve böylece kullanıcı arayüzünün düzgün bir şekilde çalışmasını sağlayabilirsiniz.

 Örneğin, kullanıcı arayüzünü güncellemek istediğinizde, DispatchQueue.main.async kullanarak UI güncellemelerini ana iş parçacığı üzerinde gerçekleştirirsiniz. Bu, arka planda yapılan işlemlerin kullanıcı arayüzünü engellemeden ve çökertmeden yapılmasını sağlar.
 */
