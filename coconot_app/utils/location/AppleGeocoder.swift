

import SwiftUI
import CoreLocation
import MapKit

struct AppleGeocoder {
    static func geocode(address: String) async throws -> LocalisationGps {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = address

        let search = MKLocalSearch(request: request)
        let response = try await search.start()

        guard let mapItem = response.mapItems.first else {
            throw NSError(domain: "AppleGeocoder", code: 404, userInfo: [NSLocalizedDescriptionKey: "No location found"])
        }

        let location = mapItem.location
        let coordinate = location.coordinate
        return LocalisationGps(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }
}

