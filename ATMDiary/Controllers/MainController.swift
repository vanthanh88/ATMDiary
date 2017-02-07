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

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let regionRadius: CLLocationDistance = 100000

    
    private var atmData: [ATMEntity] = ATMManager.sharedInstance.listOfATM()
    
    //search
    private var filteredEntities = [ATMEntity]()
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar

        tableView.estimatedRowHeight = 77.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        checkLocationAuthorizationStatus()
        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        for atm in atmData {
            let anno = ATMAnnotation(entity: atm)
            mapView.addAnnotations([anno])
            centerMapOnLocation(CLLocation(latitude: anno.coordinate.latitude, longitude: anno.coordinate.longitude))

        }
    
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

    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "ATMPin")
        if annotationView == nil{
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "ATMPin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "map-marker")
        return annotationView
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
    
    
    @IBAction func search(_ sender: Any) {
        
        searchController.isActive = true
        
    }
    func addNew(atm: ATMEntity) {
        
        let anno = ATMAnnotation(entity: atm)
        
        centerMapOnLocation(CLLocation(latitude: anno.coordinate.latitude, longitude: anno.coordinate.longitude))
        mapView.addAnnotations([anno])
        atmData.insert(atm, at: 0)
        tableView.reloadData()
    }
    
    //MARK: Table view datasource 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEntities.count
        }
        return atmData.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ATMCell.identifier, for: indexPath) as! ATMCell
        let entity: ATMEntity
        if searchController.isActive && searchController.searchBar.text != "" {
            entity = filteredEntities[indexPath.row]
        } else {
            entity = atmData[indexPath.row]
        }
        
        cell.updateCellWith(entity: entity)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity: ATMEntity
        if searchController.isActive && searchController.searchBar.text != "" {
            entity = filteredEntities[indexPath.row]
        } else {
            entity = atmData[indexPath.row]
        }

        centerMapOnLocation(CLLocation(latitude: entity.lat, longitude: entity.long))
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredEntities = atmData.filter({( entity : ATMEntity) -> Bool in
            return (entity.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }

    
    //MARK: Location manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .denied && status != .notDetermined {
            mapView.showsUserLocation = true
        }
    }

}

extension MainController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension MainController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
