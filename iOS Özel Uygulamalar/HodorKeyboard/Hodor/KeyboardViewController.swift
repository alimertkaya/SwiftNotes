//
//  KeyboardViewController.swift
//  Hodor
//
//  Created by Ali Mert Kaya on 10.07.2023.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HODOR
        let hodorButton = UIButton(type: UIButton.ButtonType.system)
        hodorButton.frame = CGRect(x: 75, y: 50, width: 140, height: 120)
        hodorButton.setBackgroundImage(UIImage(named: "hodor.png"), for: UIControl.State.normal)
        hodorButton.addTarget(self, action: #selector(hodorTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(hodorButton)
        
        // Stewie
        let stewieButton = UIButton(type: UIButton.ButtonType.system)
        stewieButton.frame = CGRect(x: 150, y: 50, width: 140, height: 120)
        stewieButton.setBackgroundImage(UIImage(named: "stewie.png"), for: UIControl.State.normal)
        stewieButton.addTarget(self, action: #selector(stewieTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(stewieButton)
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func hodorTapped() {
         
        // ekrana yazı yazdırmak için proxy oluştur
        let textProxy = textDocumentProxy as UITextDocumentProxy
        textProxy.insertText("HODOR!")
        
    }
    
    @objc func stewieTapped() {
        
        let textProxy = textDocumentProxy as UITextDocumentProxy
        textProxy.insertText("Stewie")
        
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
