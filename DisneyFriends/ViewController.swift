//
//  ViewController.swift
//  DisneyFriends
//
//  Created by Garrett on 8/12/18.
//  Copyright © 2018 Garrett. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var m_map_view: MKMapView!
    let m_location_manager = CLLocationManager();
    var m_tile_renderer: MKTileOverlayRenderer!;
    var m_map_center_init = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SetupTileRenderer();
        
        self.m_location_manager.requestAlwaysAuthorization();
        self.m_location_manager.requestWhenInUseAuthorization();
        
        if CLLocationManager.locationServicesEnabled()
        {
            m_location_manager.delegate = self;
            m_location_manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            m_location_manager.startUpdatingLocation();
        }
        
        m_map_view.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let region_radius: CLLocationDistance = 1000;
    func CenterMap(location: CLLocation)
    {
        let coordinate_region = MKCoordinateRegionMakeWithDistance(location.coordinate, region_radius, region_radius);
        m_map_view.setRegion(coordinate_region, animated: true);
    }
    
    func SetupTileRenderer()
    {
        let overlay = DisneyMapOverlay();
        overlay.canReplaceMapContent = true;
        m_map_view.add(overlay, level: .aboveLabels);
        m_tile_renderer = MKTileOverlayRenderer(tileOverlay: overlay);
    }
    
}

extension ViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        return m_tile_renderer;
    }
}

extension ViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let lat = locations.last?.coordinate.latitude, let lon = locations.last?.coordinate.longitude
        {
            if (!m_map_center_init)
            {
                CenterMap(location: CLLocation(latitude: lat, longitude: lon));
                print("\(lat), \(lon)");
                m_map_center_init = true;
            }
        }
        else
        {
            print("NO COORDINATES!");
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error);
    }
}
