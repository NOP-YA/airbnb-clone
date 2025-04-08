//
//  Listing.swift
//  AirbnbClone
//
//  Created by Henry on 4/6/25.
//

import SwiftUI

struct Listing: Identifiable, Codable, Hashable {
    let id : String
    let ownerUid: String
    let ownerName: String
    let ownerImageUrl: String
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    let numberOfGuests: Int
    let numberOfBeds: Int
    var pricePerNight: Int
    let latitude: Double
    let longitude: Double
    var imageUrls: [String]
    let address: String
    let city: String
    let state: String
    let country: String
    let title: String
    var rating: Double
    var features: [ListingFeatures]
    var amenities: [ListingAmenities]
    let type: ListingType
}

enum ListingFeatures: Int, Codable, Identifiable, Hashable {
    case selfCheckIn
    case superHost   

    var title: String {
        switch self {
            case .selfCheckIn: return "Self Check-In"
            case .superHost: return "Super Host"
        }
    }

    var description: String {
        switch self {
            case .selfCheckIn: return "Check yourself in with the keypad"
            case .superHost: return "Super Host"
        }
    }
    var imageName: String {
        switch self {
            case .selfCheckIn: return "door.left.hand.open"
            case .superHost: return "medal"
        }
    }
    

    var id: Int { return self.rawValue }
}

enum ListingAmenities: Int, Codable, Identifiable, Hashable {
    case pool
    case kitchen
    case wifi
    case laundry
    case tv
    case alarmSystem
    case office
    case balcony
    case washer

    var title: String {
        switch self {
            case .pool: return "Pool"
            case .kitchen: return "Kitchen"
            case .wifi: return "Wifi"
            case .laundry: return "Laundry"
            case .tv: return "TV"
            case .alarmSystem: return "Alarm System"
            case .office: return "Office"
            case .balcony: return "Balcony"
            case .washer: return "Washer"
        }
    }

    var imageName: String {
        switch self {
            case .pool: return "figure.pool.swim"
            case .kitchen: return "fork.knife"
            case .wifi: return "wifi"
            case .laundry: return "washer"
            case .tv: return "tv"
            case .alarmSystem: return "checkerboard.shield"
            case .office: return "pencil.and.ruler.fill"
            case .balcony: return "building"
            case .washer: return "washer"
        }
    }

    var id: Int { return self.rawValue }
}

enum ListingType: Int, Codable, Identifiable, Hashable {
    case apartment
    case house
    case townhouse
    case villa
    case hotel
    var description: String {
        switch self {
            case .apartment: return "Apartment"
            case .house: return "House"
            case .townhouse: return "Town House"
            case .villa: return "Villa"
            case .hotel: return "Hotel"
        }
    }

    var id: Int { return self.rawValue }
}