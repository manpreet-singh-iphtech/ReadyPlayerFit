//
//  LockerModel.swift
//  Ready Player Fit
//
//  Created by iPHTech34 on 27/02/26.
//

import Foundation

enum LockerCategory: String, CaseIterable {
    case tshirt = "TSHIRT"
//    case lower = "LOWER"
    case hoodie = "HOODIE"
    case shoes = "SHOES"
}

struct LockerItem {
    let name: String
    let image: String
    let desc: String
    let category: LockerCategory
}
