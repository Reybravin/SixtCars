//
//  CarModel.swift
//  CarHire
//
//  Created by SS on 4/18/19.
//  Copyright © 2019 SergiySachuk. All rights reserved.
//

import MapKit


class Car : NSObject, Decodable, MKAnnotation  {
    
    let id : String
    let modelIdentifier: String
    let modelName : String
    let name : String
    let make : String
    let group : String
    let color : String
    let series : String
    let fuelType : FuelType
    let fuelLevel : Double
    let transmission : TransmissionType
    let licensePlate: String
    var latitude : Double
    var longitude : Double
    let innerCleanliness : CleanlinessType
    let carImageUrl : String
    
    enum TransmissionType : String, Decodable {
        case mechanic = "M"
        case automatic = "A"
    }
    
    enum CleanlinessType : String, Decodable {
        case regular = "REGULAR"
        case clean = "CLEAN"
        case veryClean = "VERY_CLEAN"
    }
    
    enum FuelType : String, Decodable {
        case diesel = "D"
        case petrol = "P"
        case electric = "E"
    }
    
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
}
