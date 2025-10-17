//
//  OpenedWindowsDurationModel.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import Foundation


struct OpenedWindowsDurationModel : Identifiable {
    let id = UUID()
    let hotHouseId: String
    let openWindowTime : String
    let closeWindowTime : String
}
