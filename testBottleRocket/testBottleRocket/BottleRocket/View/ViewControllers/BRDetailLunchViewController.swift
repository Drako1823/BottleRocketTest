//
//  BRDetailLunchViewController.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit
import MapKit

class BRDetailLunchViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblSocialNetwork: UILabel!
    @IBOutlet weak var mpLocationRestaurant: MKMapView!
    @IBOutlet weak var imgAllRestaurants: UIImageView!
    
    // MARK: - Properties
    private var viewModel : BRRestaurantsViewModel = BRRestaurantsViewModel()
    private lazy var iRowSelected = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()
        setConfigurationMap()
    }
    // MARK: - IBAction
    
    @IBAction func btnReturnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func allRestaurants() {
        let allAnnotations = self.mpLocationRestaurant.annotations
        self.mpLocationRestaurant.removeAnnotations(allAnnotations)
        let productSelected = viewModel.getDataRestaurantAtIndex(withRow: iRowSelected)
        
        let pinCenter = CLLocation(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0))
        let region = MKCoordinateRegion(center: pinCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mpLocationRestaurant.setCameraBoundary( MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        mpLocationRestaurant.centerCoordinate = CLLocationCoordinate2D(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0))
        
        let zoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 100)
        mpLocationRestaurant.setCameraZoomRange(zoomRange, animated: true)
        
        mpLocationRestaurant.isZoomEnabled = true
        var allRestaurantsLocation:[pinRestaurant] = []
        
        for i in 0...viewModel.getNumberOfRowsInSection() - 1 {
            let productSelected = viewModel.getDataRestaurantAtIndex(withRow: i)
            let pinRestaurant = pinRestaurant(title: productSelected?.strName, coordinate: CLLocationCoordinate2D(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0)))
            allRestaurantsLocation.append(pinRestaurant)
        }
        mpLocationRestaurant.addAnnotations(allRestaurantsLocation)
    }
    
    // MARK: - Functions
    
    func loadInfo(){
        let productSelected = viewModel.getDataRestaurantAtIndex(withRow: iRowSelected)
        lblRestaurantName.text = productSelected?.strName
        lblCategoryName.text = productSelected?.strCategory
        lblAddress.text = "\(productSelected?.arrLocation?.strAddress ?? ""), \(productSelected?.arrLocation?.strCity ?? ""), \(productSelected?.arrLocation?.strState ?? "")\(productSelected?.arrLocation?.strPostalCode ?? "")"
        if let phoneFormatted = productSelected?.arrContact?.strFormatedPhone {
            lblPhone.text = phoneFormatted
        }
        if let socialNetwork = productSelected?.arrContact?.strSocialNetwork {
            lblSocialNetwork.text = "@\(socialNetwork)"
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.allRestaurants))
        imgAllRestaurants.addGestureRecognizer(tap)
        imgAllRestaurants.isUserInteractionEnabled = true
    }
    
    func setConfigurationMap(){
        let productSelected = viewModel.getDataRestaurantAtIndex(withRow: iRowSelected)
        let pinRestaurant = pinRestaurant(title: productSelected?.strName, coordinate: CLLocationCoordinate2D(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0)))
        
        mpLocationRestaurant.addAnnotation(pinRestaurant)
        
        let pinCenter = CLLocation(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0))
        let region = MKCoordinateRegion(center: pinCenter.coordinate, latitudinalMeters: pinCenter.coordinate.latitude, longitudinalMeters: pinCenter.coordinate.longitude)
        mpLocationRestaurant.setCameraBoundary( MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        mpLocationRestaurant.setCenter( CLLocationCoordinate2D(latitude: Double(productSelected?.arrLocation?.fLatitud ?? 0), longitude: Double(productSelected?.arrLocation?.fLongitud ?? 0)), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000)
        mpLocationRestaurant.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func setViewModel(withVM viewModel:BRRestaurantsViewModel, withRowSelected iRowSelected: Int){
        self.viewModel = viewModel
        self.iRowSelected = iRowSelected
    }
}
