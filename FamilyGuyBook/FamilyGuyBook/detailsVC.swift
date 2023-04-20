//
//  detailsVC.swift
//  FamilyGuyBook
//
//  Created by Ali Mert Kaya on 18.04.2023.
//

import UIKit

class detailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    var selectedFamilyGuy : FamilyGuy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = selectedFamilyGuy?.name
        jobLabel.text = selectedFamilyGuy?.job
        imageView.image = selectedFamilyGuy?.image
    }
}
