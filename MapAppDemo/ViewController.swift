//
//  ViewController.swift
//  MapAppDemo
//
//  Created by 川島壮生 on 2020/05/22.
//  Copyright © 2020 川島壮生. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    var myLock = NSLock()
    let goldenRatio = 1.618
    
@IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!

    @IBAction func clickZoomin(_ sender: Any) {
        myLock.lock()
        if (0.005 < mapView.region.span.latitudeDelta / goldenRatio) {
            var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
            regionSpan.latitudeDelta = mapView.region.span.latitudeDelta / goldenRatio
                mapView.region.span = regionSpan
            }
            myLock.unlock()
            
    }
    @IBAction func clickZoomout(_ sender: Any) {
        myLock.lock()
        if (mapView.region.span.latitudeDelta * goldenRatio < 150.0) {
            var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
            regionSpan.latitudeDelta = mapView.region.span.latitudeDelta * goldenRatio
            mapView.region.span = regionSpan
        }
        myLock.unlock()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
    mapView.setCenter((locations.last?.coordinate)!, animated: true)
}

}


