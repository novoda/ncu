//
//  Office.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

enum Office: String, CaseIterable, Decodable, Encodable { // Will be based on downloaded data? Hardcoded?
    case barcelona
    case berlin
    case london
    case liverpool
    
    var readable: String {
        return self.rawValue.capitalizingFirstLetter()
    }
}
