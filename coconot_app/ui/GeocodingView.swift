//
//  GeocodingView.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI
import CoreLocation

struct GeocodingView: View {
    @State private var address: String = ""
    @State private var coordinate: CLLocationCoordinate2D?
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Géocoder une adresse")
                .font(.title.bold())

            TextField("Entrez une adresse", text: $address)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Obtenir les coordonnées") {
                Task {
                    let test = try await AppleGeocoder.geocode(address: "17 bd velasquez 13008")
                    print(test)
                }
            }
            .buttonStyle(.borderedProminent)
            //.disabled(address.isEmpty)

            if let coordinate {
                VStack {
                    Text("Latitude : \(coordinate.latitude)")
                    Text("Longitude : \(coordinate.longitude)")
                }
                .font(.body.monospaced())
            }
            else {
                Text("Erreur de récupération datas")
            }

            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            Spacer()
        }
        .padding()
    }

}
