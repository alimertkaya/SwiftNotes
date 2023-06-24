//
//  ViewController.swift
//  TravelBook
//
//  Created by Ali Mert Kaya on 24.04.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    // Konum ile ilgili işlemler yapıcaksak, import CoreLocation
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedTitleID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // VC ye protokollerden bazı fonksiyonları çağırma hakkı verir
        mapView.delegate = self
        locationManager.delegate = self
        
        // Konum ne kadar kesin bulunucak, pil harcama durumuna göre karar verilir
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Kullanıcıdan izin istiyoruz
        locationManager.requestWhenInUseAuthorization()
        // Kullanıcının yerini almaya başlıyoruz
        locationManager.startUpdatingLocation()
        
        // Uzun basınca çağrılacak
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer: )))
        
        // Kullanıcı kaç saniye basıcak
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // Boş değil ise veri çekicez
        if selectedTitle != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let title = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                                
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    
                                    if let longitude = result.value(forKey: "longitude") as? Double {
                                        annotationLongitude = longitude
                                        
                                        // annotation oluşturuyoruz
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        
                                        mapView.addAnnotation(annotation)
                                        nameText.text = annotationTitle
                                        commentText.text = annotationSubtitle
                                        
                                        // Kullanıcının konumu almayı bırak
                                        locationManager.stopUpdatingLocation()
                                        
                                        // Zoom işlemi
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
                
            } catch {
                print("error")
            }
            
        }
        // Boş ise yeni veri ekleriz
        else {
            
        }
    }
    
    // gestureRecognizer metotlarına ulaşmak için bu şekilde tanımladık
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        // Dokunma işlevi var mı başladı mı
        if gestureRecognizer.state == .began {
            
            // Dokunulan nokta
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            // Dokunulan noktayı koordinata çevircek
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            // latitude ve longitude değerleri veritabanında kullanmak için alıyoruz
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            // title boş ise pin oluşturmaz
            if nameText.text != "" {
                // Pin oluşturma
                let annotation = MKPointAnnotation()
                annotation.coordinate = touchedCoordinates
                annotation.title = nameText.text
                annotation.subtitle = commentText.text
                self.mapView.addAnnotation(annotation)
            }
            else {
                print("Please enter a name first")
            }
        }
    }
    
    // Kullanıcının yerini aldığımız zaman ne yapıcaz
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == "" {
            // Bir konum oluşturduk
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            // Açılışta zoom seviyesi oluşturuyoz
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Kullanıcının yerine pin vs ile göstermek istemiyorum, tıklanan yeri gösterir
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        // pinView boş ise, oluşturulmamış ise
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            // Bir baloncuk ile ekstra bilgi gösterir
            pinView?.canShowCallout = true
            // Annotation rengi
            pinView?.tintColor = UIColor.black
            
            // ShowCallout içersine button oluştururuz, detay gösterir
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    // Pin üzerinde çıkan Information simgesine tıklanırsa ne olacak
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Seçilen bir yer var mı
        if selectedTitle != "" {
            
            // koordinatları aldık
            var requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            // Koordinatlar ve yerler arasında bağlantı kurmayı sağlar
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                // closure
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        
                        // Navigasyonu çalıştırmak için MKPlacemark lazım ondan bu işlemler
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        
                        // Nasıl bir nagigasyon olacak
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        // Navigasyonu açar
                        item.openInMaps(launchOptions: launchOptions)
                        
                        // Nagivasyonu açabilmek için MKMapItem oluşturmak gerekiyor. Sonra MKMapItem içerisinde hangi mod ile açılacağı belirtirlir.
                        // MKMapItem oluşturmak için PlaceMark object gerekiyor. Bu object i reverseGeocodeLocation denilen metotla alınır.
                    }
                }
            }
            
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Veritabanına Places için yeni bir veri ekler
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        // Bütün app e bir mesaj yollar
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        // Bir önceki VC e götürür
        navigationController?.popViewController(animated: true)
    }
    
}
