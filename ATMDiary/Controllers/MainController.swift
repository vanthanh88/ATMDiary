//
//  MainController.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit
import MapKit

private let AddNewATMSegue = "AddNewATMSegue"

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()

    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let regionRadius: CLLocationDistance = 1000

    
    private var atmData: [ATMEntity] = ATMManager.sharedInstance.listOfATM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Map support
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier, identifier == AddNewATMSegue {
            let nextVC = segue.destination as! AddNewATMController
            nextVC.mainVC = self
        }
    }
    
    
    func addNew(atm: ATMEntity) {
        atmData.insert(atm, at: 0)
        tableView.reloadData()
    }
    
    //MARK: Table view datasource 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atmData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ATMCell.identifier, for: indexPath) as! ATMCell
        let entity = atmData[indexPath.row]
        cell.updateCellWith(entity: entity)
        return cell
    }
    
    
    //MARK: Location manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .denied && status != .notDetermined {
            mapView.showsUserLocation = true
        }
    }

}
