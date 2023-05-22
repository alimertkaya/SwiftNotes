//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Ali Mert Kaya on 18.04.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // + butonu oluşturma
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        
        getData()
    }
    
    // VC açıldığı her zaman çalışır
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    // coredata dan verileri çekicez
    @objc func getData() {
        
        // array leri temizler, dizilerde iki kere gözükmemesi için birçok kez verileri çekiyoruz
        nameArray.removeAll()
        idArray.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        
        /* nesnelerin tümünün yüklenmesini sağlar, küçük veri kümeleri ile çalışırken hızını arttırır ancak
         nesneler yüklü olduğu için bellek kullanımını arttırır.Büyük veriler de true olması daha iyi */
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            // veriyi çekeriz, değişkene atıyoruz ki loop felan yapıp elemanları tek tek inceleyebiliriz
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                // tek bir resulta odaklanmak için casting yapıyoruz
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    
                    // value(forkey:) Any? tipinde değer döndürdüğü için casting yapmak mantıklı
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    // yeni data geldiği zaman tableView güncellensin
                    self.tableView.reloadData()
                }
            }

        } catch {
            print("error")
        }
        
    }
    
    @objc func addButtonClicked() {
        selectedPainting = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    // Bir veriye tıklandığında segue yapıcak
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // Silme,düzenleme gibi işlemler için
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // Veriyi çekip silicez
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString
            
            // predicate kullanıcaz çünkü sadece bir tane veriyi silmek için
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                // Core data da yapılan işlemi bitiriyoruz
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                
                                break
                            }
                        }
                    }
                }
            } catch {
                printContent("error")
            }
        }
    }
}

