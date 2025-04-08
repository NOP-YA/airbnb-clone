//
//  Regions.swift
//  AirbnbClone
//
//  Created by Henry on 4/8/25.
//

import CoreLocation

extension CLLocationCoordinate2D {
    static var losAngels = CLLocationCoordinate2D(latitude: 34.0549, longitude: -118.2426)
    static var miami = CLLocationCoordinate2D(latitude: 25.7602, longitude: -80.1959)

    func regionForCity(_ name: String) -> CLLocationCoordinate2D {
        switch name {
            case "Los Angeles": return .losAngels
            case "Miami": return .miami
            default: return .losAngels
        }
    }
}
