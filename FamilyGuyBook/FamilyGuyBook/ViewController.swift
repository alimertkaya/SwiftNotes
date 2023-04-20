//
//  ViewController.swift
//  FamilyGuyBook
//
//  Created by Ali Mert Kaya on 18.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myGuys = [FamilyGuy]()
    var choosenGuy : FamilyGuy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // FamilyGuy Objects
        
        let peter = FamilyGuy(name: "Peter Griffin", job: "Meg's Father", image: UIImage(named: "peter")!)
        let lois = FamilyGuy(name: "Lois Griffin", job: "Housewife", image: UIImage(named: "lois")!)
        let chris = FamilyGuy(name: "Chris Griffin", job: "Student", image: UIImage(named: "chris")!)
        let stewie = FamilyGuy(name: "Stewie Griffin", job: "Baby", image: UIImage(named: "stewie")!)
        let brian = FamilyGuy(name: "Brian Griffin", job: "Pet", image: UIImage(named: "brian")!)
        let meg = FamilyGuy(name: "Meg Griffin", job: "Student", image: UIImage(named: "meg")!)
        
        myGuys.append(peter)
        myGuys.append(lois)
        myGuys.append(chris)
        myGuys.append(stewie)
        myGuys.append(brian)
        myGuys.append(meg)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGuys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = myGuys[indexPath.row].name
        return cell
    }
    
    // tableview seçilince gitsin karşı tarafa
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenGuy = myGuys[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedFamilyGuy = choosenGuy
        }
    }
}

