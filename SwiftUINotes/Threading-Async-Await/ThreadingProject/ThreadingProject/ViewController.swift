//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Ali Mert Kaya on 15.08.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    let urlStrings = ["https://hdwallsource.com/img/2014/7/large-40567-41517-hd-wallpapers.jpg","https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg"]
    var data = Data()
    var tracker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // DispatchQueue -> Task lerin aynı anda veya seri olarak yapılacağına, arka planda(background) veya main thread mi yapılacağına karar verir
        // Background da yapar
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background thread
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main thread
            }
        }
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
    }
    
    @objc func changeImage() {
        if tracker == 0 {
            tracker += 1
        }
        else {
            tracker -= 1
        }
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background thread
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main thread
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threading Test"
        return cell
    }
}

