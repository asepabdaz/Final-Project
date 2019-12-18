//
//  MapViewController.swift
//  Final Project
//
//  Created by Asep Abdaz on 17/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var locationMapKit: MKMapView!
    @IBOutlet weak var reCenterButton: UIButton!
    let regionInMeters: Double = 1000
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        reCenterButton.layer.cornerRadius = 5
    
        checkLocationService()
        // Do any additional setup after loading the view.
    }
    @IBAction func saveMapLocation(_ sender: UIButton) {
        let coordinate = locationMapKit.centerCoordinate
        getAddress(coordinate.latitude, coordinate.longitude)
        //pencarian
//        coordinates(forAddress: "YOUR ADDRESS") {
//            (location) in
//            guard let location = location else {
//                // Handle error here.
//                return
//            }
//            openMapForPlace(lat: location.latitude, long: location.longitude)
//        }
    }
    @IBAction func reCenter(_ sender: Any) {
        locationMapKit.zoomToUserLocation()
    }
    
    func getAddress(_ lat: CLLocationDegrees, _ long: CLLocationDegrees) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
//        let lat: Double = Double("\(latitude)")!
//        let long: Double = Double("\(longtitude)")!
        
        let ceo: CLGeocoder = CLGeocoder()
        
        center.latitude = lat
        center.longitude = long
        var coorDinate: [String] = []
        coorDinate.append("\(lat)")
        coorDinate.append("\(long)")
        
        UserDefaults.standard.set(coorDinate, forKey: "coorDinate")
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc) { (placemarks, error) in
            if(error != nil){
                fatalError("error location \(error?.localizedDescription)")
            }else{
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.thoroughfare != nil {
                        //jalana
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    
                    if pm.subLocality != nil {
                        //desa
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    
                    
                    
                    if pm.locality != nil {
                        //kecamatan
                        UserDefaults.standard.set("\(pm.locality!)", forKey: "Kecamatan")
                    }
                    if  pm.administrativeArea != nil {
                        //provinsi
                        UserDefaults.standard.set("\(pm.administrativeArea!)", forKey: "Provinsi")
                    }
                    if pm.country != nil {
                        //negara
                        UserDefaults.standard.set("\(pm.country!)", forKey: "Country")
                    }
                    if pm.postalCode != nil {
                        //kodepos
                        UserDefaults.standard.set("\(pm.postalCode!)", forKey: "PostalCode")
                    }

                    UserDefaults.standard.set("\(addressString)", forKey: "AlamatLengkap")
                }
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: AlamatViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }

    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do Map stuff
            locationMapKit.showsUserLocation = true
//            centerViewOnUserLocation()
            locationMapKit.zoomToUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //show alert instructing them how to torn on
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show alert letting them know whats up
            break
        case .authorizedAlways:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            locationMapKit.setRegion(region, animated: true )
        }
    }
    func checkLocationService() {
    
        if CLLocationManager.locationServicesEnabled() {
//            // setup location manager
            setupLoactionManager()
            checkLocationAuthorization()
        }else{
//            // show alert
        }
    }
    

    
    func setupLoactionManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //we will back
//        guard let location = locations.last else { return }
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        locationMapKit.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //we will back
        checkLocationAuthorization()
    }
}
