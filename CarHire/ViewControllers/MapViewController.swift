//
//  ViewController.swift
//  CarHire
//
//  Created by SS on 4/17/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: - Properties
    
    lazy var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private var carAnnotations : [Car] = []
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCarAnnotations()
    }
    
    //MARK: - Methods
    
    private func setupView(){
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func updateCarAnnotations(){
        
        SixtAPI.fetchCars { [weak self] (result) in
            switch result {
            case .success(let cars):
                guard let strongSelf = self else { return }
                strongSelf.carAnnotations = cars
                strongSelf.addCarAnnotations()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    private func addCarAnnotations(){
        mapView.addAnnotations(carAnnotations)
    }
    
}


//MARK: - MapView Delegate Methods

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Car else { return nil }
        return CarAnnotationView(annotation: annotation, reuseIdentifier: CarAnnotationView.ReuseID)
    }
}
