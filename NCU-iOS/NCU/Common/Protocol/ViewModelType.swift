//
//  ViewModelType.swift
//  NCU
//
//  Created by Simon Rowlands on 15/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
