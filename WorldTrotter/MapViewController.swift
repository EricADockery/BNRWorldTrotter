//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Eric Dockery on 1/3/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let dropPin = MKPointAnnotation()
    let NYC = "NYC"
    let GNV = "GNV"
    let home = "home"
    var location = "NYC"
    let standardString = NSLocalizedString("Standard", comment: "Standard Map View")
    let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid Map View")
    let satelliteString = NSLocalizedString("Satellite", comment: "Satellite Map View")
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        setupSegmentedController()
    }
    
    func setupSegmentedController() {
        //since I did not set up the segmented controller constraints programatically I will have to update it here.
        segmentedController.setTitle(standardString, forSegmentAt: 0)
        segmentedController.setTitle(hybridString, forSegmentAt: 1)
        segmentedController.setTitle(satelliteString, forSegmentAt: 2)
        
        segmentedController.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.selectedSegmentIndex = 0
        //segmented controller target
        segmentedController.addTarget(self, action: #selector(self.mapTypeChanged), for: .valueChanged)
        
        mapView.addSubview(segmentedController)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func newYorkPin() {
        let newYorkLocation = CLLocationCoordinate2DMake(40.730872, -74.003066)
        // Drop a pin
        dropPin.coordinate = newYorkLocation
        dropPin.title = NSLocalizedString("New York City", comment: "New York City")
        location = GNV
    }
    func gainesvillePin() {
        let gainesvilleLocation = CLLocationCoordinate2DMake(29.6516, -82.3248)
        dropPin.coordinate = gainesvilleLocation
        dropPin.title = "Gainesville"
        location = home
    }
    func homePin() {
        let homeLocation = CLLocationCoordinate2DMake(38.2527, -85.7585)
        dropPin.coordinate = homeLocation
        dropPin.title = "Louisville"
        location = NYC
    }
   
    @IBAction func cycleThroughPins(_ sender: UIButton) {
        let defaultRegion = MKCoordinateRegionMake(mapView.centerCoordinate, MKCoordinateSpanMake(100, 100))
        mapView.setRegion(defaultRegion, animated: true)
        switch location {
        case "NYC":
            newYorkPin()
        case "GNV":
            gainesvillePin()
        default:
            homePin()
        }
        mapView.addAnnotation(dropPin)
    }
    
    @IBAction func findUser(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
}
