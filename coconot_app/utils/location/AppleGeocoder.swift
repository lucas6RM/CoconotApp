

import SwiftUI
import CoreLocation


struct AppleGeocoder {
    static func geocode(address: String) async throws -> LocalisationGps {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let location = placemarks.first?.location?.coordinate else {
            throw NSError(domain: "No location found", code: 404)
        }

        return LocalisationGps(
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
}
