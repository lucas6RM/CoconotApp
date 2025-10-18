//
//  AddEditHotHouseView 2.swift
//  coconot_app
//
//  Created by lucas mercier on 17/10/2025.
//


import SwiftUI
import Factory
import MapKit

struct AddEditHotHouseView: View {
    
    @State private var vm = Container.shared.hotHouseViewModel()
    let selectedHotHouseId: String?
    
    var isEditingHotHouse: Bool {
        if let id = selectedHotHouseId {
            return true
        } else {
            return false
        }
    }
    
    var onDismiss: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValidatingAddress = false
    @State private var addressError: String?
    @State private var addressValidated = false
    
    private var numberFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 2
        f.usesGroupingSeparator = false
        return f
    }
    
    var body: some View {
        NavigationStack {
            
            Form {
                // MARK: Informations
                Section("Informations") {
                    TextField("Nom", text: Binding(
                        get: { vm.currentHouse?.name ?? "" },
                        set: { vm.currentHouse?.name = $0 }
                    ))
                }
                
                // MARK: Adresse
                Section("Adresse") {
                    TextField("Rue", text: Binding(
                        get: { vm.currentHouse?.address?.addressStreet ?? "" },
                        set: { vm.currentHouse?.address?.addressStreet = $0 }
                    ))
                    TextField("Code postal", text: Binding(
                        get: { vm.currentHouse?.address?.postalCode ?? "" },
                        set: { vm.currentHouse?.address?.postalCode = $0 }
                    ))
                    .keyboardType(.numberPad)
                    TextField("Ville", text: Binding(
                        get: { vm.currentHouse?.address?.city ?? "" },
                        set: { vm.currentHouse?.address?.city = $0 }
                    ))
                    
                    Button {
                        Task {
                            await validateAddress()
                        }
                    } label: {
                        HStack {
                            if let error = addressError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            if addressValidated {
                                Text("Adresse validée ✅")
                                    .foregroundColor(.green)
                                    .font(.caption)
                            }
                            Spacer()
                            Text("Valider l’adresse")
                            if isValidatingAddress {
                                ProgressView().scaleEffect(0.6)
                            }
                        }
                    }
                    .disabled((vm.currentHouse?.address?.addressStreet ?? "").isEmpty ||
                              (vm.currentHouse?.address?.postalCode ?? "").isEmpty ||
                              (vm.currentHouse?.address?.city ?? "").isEmpty)
                    
                    if addressValidated {
                        if let location = vm.currentHouse?.location {
                            HStack {
                                Text("Latitude : ")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(location.latitude.description)
                            }
                            HStack {
                                Text("Longitude : ")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(location.longitude.description)
                            }
                        }
                    }
                }
                
                // MARK: Seuils température
                Section(header: Text("Seuils température (°C)")) {
                    thresholdField(
                        title: "Min (°C)",
                        value: Binding(
                            get: { vm.currentHouse?.temperatureThresholdMin ?? 0 },
                            set: { vm.currentHouse?.temperatureThresholdMin = $0 }
                        )
                    )
                    thresholdField(
                        title: "Max (°C)",
                        value: Binding(
                            get: { vm.currentHouse?.temperatureThresholdMax ?? 0 },
                            set: { vm.currentHouse?.temperatureThresholdMax = $0 }
                        )
                    )
                }
                
                // MARK: Seuils humidité
                Section(header: Text("Seuils humidité (%)")) {
                    thresholdField(
                        title: "Min (%)",
                        value: Binding(
                            get: { vm.currentHouse?.humidityThresholdMin ?? 0 },
                            set: { vm.currentHouse?.humidityThresholdMin = $0 }
                        )
                    )
                    thresholdField(
                        title: "Max (%)",
                        value: Binding(
                            get: { vm.currentHouse?.humidityThresholdMax ?? 0 },
                            set: { vm.currentHouse?.humidityThresholdMax = $0 }
                        )
                    )
                }
                
                // MARK: Bouton de suppression
                if isEditingHotHouse {
                    Section {
                        Button(role: .destructive) {
                            Task {
                                vm.deleteHotHouseById(hotHouseId: selectedHotHouseId!)
                                dismiss()
                                onDismiss()
                            }
                        } label: {
                            Text("Supprimer la serre")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle(vm.currentHouse == nil ? "Nouvelle Serre" : (vm.currentHouse?.name ?? ""))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(vm.currentHouse == nil ? "Ajouter" : "Valider") {
                        Task { await saveHotHouse() }
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss(); onDismiss() }
                }
            }
            .task {
                if let id = selectedHotHouseId {
                    await vm.getHotHouseById(hotHouseId: id)
                } else {
                    vm.currentHouse = HotHouseModel.empty()
                }
            }
        }
    }
}

// MARK: - Helpers
private extension AddEditHotHouseView {
    
    var isFormValid: Bool {
        guard let house = vm.currentHouse else { return false }
        return !house.name.trimmingCharacters(in: .whitespaces).isEmpty && addressValidated
    }
    
    func validateAddress() async {
        guard let addr = vm.currentHouse?.address else { return }
        let fullAddress = "\(addr.addressStreet), \(addr.postalCode) \(addr.city)"
        isValidatingAddress = true
        addressError = nil
        do {
            let modelLocation = try await AppleGeocoder.geocode(address: fullAddress)
            vm.currentHouse?.location = modelLocation
            addressValidated = true
        } catch {
            addressError = "Adresse introuvable"
            addressValidated = false
        }
        isValidatingAddress = false
    }
    
    func saveHotHouse() async {
        guard let house = vm.currentHouse,
              let address = house.address,
              let location = house.location else { return }
        
        if selectedHotHouseId == nil {
            let dto = CreateHotHouseDto(
                name: house.name,
                address: AddressDto(address),
                location: LocalisationGpsDto(location),
                temperatureThresholdMax: house.temperatureThresholdMax,
                temperatureThresholdMin: house.temperatureThresholdMin,
                humidityThresholdMax: house.humidityThresholdMax,
                humidityThresholdMin: house.humidityThresholdMin
            )
            vm.addHotHouse(dto)
        } else {
            let dto = UpdateHotHouseDto(
                
                name: house.name,
                address: AddressDto(address),
                location: LocalisationGpsDto(location),
                temperatureThresholdMax: house.temperatureThresholdMax,
                temperatureThresholdMin: house.temperatureThresholdMin,
                humidityThresholdMax: house.humidityThresholdMax,
                humidityThresholdMin: house.humidityThresholdMin
            )
            vm.editHotHouse(dto: dto, hotHouseId: house.id)
        }
        dismiss()
        onDismiss()
    }
    
    func thresholdField(title: String, value: Binding<Double>) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            TextField("", value: value, formatter: numberFormatter)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
        }
    }
}
