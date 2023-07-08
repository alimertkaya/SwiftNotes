//
//  ViewController.swift
//  DarkMode
//
//  Created by Ali Mert Kaya on 8.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // VC nin görünümden bağımsız görüntüsünü ayarlar
        overrideUserInterfaceStyle = .light
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Dark mı light mi olduğunu anlamak için
        // TraitCollection güncel çevrenin nasıl olduğunu söyler
        // Kullanıcının arayüzü stilini verir
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            changeButton.tintColor = UIColor.white
        }
        else {
            changeButton.tintColor = UIColor.blue
        }
    }
    
    // Traitlerden biri değiştirildiğinde çalışır
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        // Dark mı light mi olduğunu anlamak için
        // TraitCollection güncel çevrenin nasıl olduğunu söyler
        // Kullanıcının arayüzü stilini verir
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            changeButton.tintColor = UIColor.white
        }
        else {
            changeButton.tintColor = UIColor.blue
        }
    }
}

