//
//  Craft.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

enum Craft: String, CaseIterable, Decodable, Encodable { // Available on hibob?
    case androidCraftmanship = "Android Craftmanship"
    case iOSCraftmanship = "iOS Craftmanship"
    case qa = "QA"
    case designer = "Designer"
}
