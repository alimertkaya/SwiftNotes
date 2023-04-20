//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Ali Mert Kaya on 14.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    var choosenLandmarkName = ""
    var choosenLandmarkImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.append("Colosseum")
        landmarkNames.append("Great Wall")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Stonehenge")
        landmarkNames.append("Tac Mahal")
        
        landmarkImages.append(UIImage(named: "colosseum.jpg")!)
        landmarkImages.append(UIImage(named: "greatwall.jpeg")!)
        landmarkImages.append(UIImage(named: "kremlin.jpeg")!)
        landmarkImages.append(UIImage(named: "stonehenge.jpeg")!)
        landmarkImages.append(UIImage(named: "tacmahal.jpeg")!)
        
    }

    // numberofRowsInSeciton girdi sayısını belirtir
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    // cellForRowAt ne gösterileceğini belirtir
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // cell.textLabel?.text = "test" eski tarz
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row]
        // content.text = "TableView"
        // content.secondaryText = "Test"
        cell.contentConfiguration = content
        return cell
    }
    
    // Cell in bir row u seçildiğinde ne yapım
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        choosenLandmarkName = landmarkNames[indexPath.row]
        choosenLandmarkImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // segue olmadan önce ne olsun
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedLandmarkName = choosenLandmarkName
            destinationVC.selectedLandmarkImage = choosenLandmarkImage
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.landmarkNames.remove(at: indexPath.row)
            self.landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

