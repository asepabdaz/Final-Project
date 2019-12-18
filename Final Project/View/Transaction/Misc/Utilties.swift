//
//  Utilties.swift
//  Final Project
//
//  Created by Asep Abdaz on 17/12/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import MapKit
import UIKit

extension MKMapView{
    func zoomToUserLocation() {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        setRegion(region, animated: true)
    }
}
