//
//  PinRestaurant.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import MapKit

class pinRestaurant: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init( title: String?,coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
